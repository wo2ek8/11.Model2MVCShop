package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping(value="json/addUser", method=RequestMethod.POST)
	public void addUser(@RequestBody User user) throws Exception {
		System.out.println("/user/json/addUser : POST");
		
		userService.addUser(user);
		
		System.out.println("json/addUser ��!");
	}
	
	@RequestMapping(value="json/updateUser/{userId}", method=RequestMethod.GET)
	public User updateUser(@PathVariable String userId) throws Exception {
		System.out.println("/user/json/updateUser : GET");
		
		User user = userService.getUser(userId);
		
		System.out.println(user);
		
		System.out.println("json/updateUser/{userId} ��!");
		
		
		return user;
	}
	
	@RequestMapping(value="json/updateUser", method=RequestMethod.POST)
	public void updateUser(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("user/json/updateUser : POST ����");
		
		userService.updateUser(user);
		
		System.out.println("json/updateUser ��");
		
	}
	
	
	
	@RequestMapping(value="json/checkDuplication", method=RequestMethod.POST)
	public Map checkDuplication(@RequestBody User user) throws Exception {
		
		System.out.println("json/checkDuplication/{userId} ����");
		
		boolean result = userService.checkDuplication(user.getUserId());
		
		Map map = new HashMap();
		map.put("result", new Boolean(result));
		map.put("userId", user.getUserId());
		
		System.out.println("json/checkDuplication/{userId} ��");
		
		return map;
	}
	
	@RequestMapping(value="json/listUser", method=RequestMethod.GET)
	public Map listUser() throws Exception {
		
		System.out.println("json/listUser : GET ����");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = userService.getUserList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map map2 = new HashMap();
		map2.put("list", map.get("list"));
		map2.put("resultPage", resultPage);
		map2.put("search", search);
		
		System.out.println("json/listUser : GET ��");
		
		return map2;
	}
}