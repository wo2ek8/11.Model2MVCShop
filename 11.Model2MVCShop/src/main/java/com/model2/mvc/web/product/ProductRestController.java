package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public void addProduct(@RequestBody Product product) throws Exception {
		
		System.out.println("json/addProduct : POST 시작");
		
		
		
		
		productService.addProduct(product);
		
		System.out.println("json/addProduct : POST 끝");
	}
	
	@RequestMapping(value="json/getHistory/{prodNo}", method=RequestMethod.GET)
	public void getHistory(@PathVariable String prodNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("json/getHistory/{prodNo} : GET 시작");
		
		Cookie[] cookies = request.getCookies();
		
		String noLine = "";
		
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("history")) {
					noLine += cookies[i].getValue();
				}
			}
		}
		if(noLine != "") {
			noLine = prodNo + "," + noLine;
		} else {
			noLine = prodNo;
		}
		
		Cookie cookie = new Cookie("history", noLine);
		
		System.out.println("noLine : " + noLine);
		
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		
		System.out.println("json/getHistory/{prodNo} : GET 끝");
	}
	
	@RequestMapping(value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Map getProduct(@PathVariable String prodNo) throws Exception {
		System.out.println("json/getProduct/{prodNo} : GET 시작");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		Search search = new Search();
		Map<String, Object> map = reviewService.getReviewList(search, Integer.parseInt(prodNo));
		
		Map map2 = new HashMap();
		map2.put("product", product);
		map2.put("list", map.get("list"));
		
		System.out.println("json/getProduct/{prodNo} : GET 끝");
		
		return map2;
	}
	
	@RequestMapping(value="json/getHistoryList", method=RequestMethod.GET)
	public void getHistoryList(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("json/getHistoryList : GET 시작");
		
		String history = null;
		Cookie[] cookies = request.getCookies();
		System.out.println("cookies : " + cookies);
		
		List<Product> list = new ArrayList<Product>();
		if(cookies != null && cookies.length > 0) {
			for(int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				System.out.println("cookie : " + cookie);
				System.out.println("cookie.getName() : " + cookie.getName());
				if(cookie.getName().equals("history")) {
					history = cookie.getValue();
					System.out.println("history : " + history);
				}
			}
			if(history != null) {
				String[] h = history.split(",");
				for(int i = 0; i < h.length; i++) {
					if(!h[i].equals("null")) {
						System.out.println("h[i] : " + h[i]);
						
						Product product = productService.getProduct(Integer.parseInt(h[i]));
						
						if(product.getQuantity() >= 1) {
							list.add(product);
						}
					}
				}
			}
		}
		session.setAttribute("list", list);
		
		System.out.println("json/getHistoryList : GET 끝");
		
	}
	
	@RequestMapping(value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct(@PathVariable int prodNo) throws Exception {
		System.out.println("json/updateProduct/{prodNo} : GET 시작");
		
		Product product = productService.getProduct(prodNo);
		
		
		
		System.out.println("json/updateProduct/{prodNo} : GET 끝");
		
		return product;
	}
	
	@RequestMapping(value="json/updateProduct", method=RequestMethod.POST)
	public void updateProduct(@RequestBody Product product) throws Exception {
		System.out.println("json/updateProduct : POST 시작");
		
		productService.updateProduct(product);
		
		
		
		System.out.println("json/updateProduct : POST 끝");
		
		
	}
	
	@RequestMapping(value="json/listProduct", method=RequestMethod.POST)
	public Map listProduct(@RequestBody Search search, HttpServletRequest request) throws Exception {
		
		System.out.println("json/listProduct : GET 시작");
		
		
		
		
		
		
		
		search.setPageSize(pageSize);
		
		
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		
		Map map2 = new HashMap();
		map2.put("list", map.get("list"));
		map2.put("resultPage", resultPage);
		map2.put("search", search);
		System.out.println("map.get(\"list\")" + map.get("list"));
		System.out.println("json/listProduct : GET 끝");
		
		return map2;
	}
	
	@RequestMapping(value="json/addCart/{prodNo}/{userId}", method=RequestMethod.GET)
	public void addCart(@PathVariable String prodNo, @PathVariable String userId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("json/addCart : GET 시작");
		
		
		Cookie[] cookies = request.getCookies();
		String cart = "";
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals(userId)) {
					cart += cookies[i].getValue();
				}
			}
		}
		
		if(cart.contains(prodNo)) {
			
		} else {
			if(cart != "") {
				cart = prodNo + "," + cart;
			} else {
				cart = prodNo;
			}
		}
		
		System.out.println("cart : " + cart);
		
		Cookie cookie = new Cookie(userId, cart);
		
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		
		
		System.out.println("json/addCart : GET 끝");
	}
	
	@RequestMapping(value="json/listCart", method=RequestMethod.GET)
	public List listCart(HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("json/listCart : GET 시작");
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		String cart = null;
		
		List<Product> list = new ArrayList<Product>();
		Cookie[] cookies = request.getCookies();
		if(cookies != null && cookies.length > 0) {
			for(int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if(cookie.getName().equals(userId)) {
					cart = cookie.getValue();
				}
			}
			System.out.println("cart : " + cart);
			if(cart != null) {
				String[] c = cart.split(",");
				System.out.println("c : " + c);
				
				for(int i = 0; i < c.length; i++) {
					if(!(c[i] == null) && !c[i].equals("")) {
						Product product = productService.getProduct(Integer.parseInt(c[i]));
						System.out.println("product : " + product);
						
						if(product.getQuantity() >= 1) {
							list.add(product);
						}
					}
				}
			}
		}
		
		session.setAttribute("list", list);
		
		System.out.println("list : " + list);
		
		System.out.println("json/listCart : GET 끝");
		
		return list;
	}
	
	@RequestMapping(value="json/removeCart/{prodNo}", method=RequestMethod.GET)
	public void removeCart(@PathVariable String prodNo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("json/removeCart : GET 시작");
		
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		Cookie[] cookies = request.getCookies();
		String cart = "";
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals(userId)) {
					cart += cookies[i].getValue();
				}
			}
		}
		System.out.println("cart : " + cart);
		if(cart.contains(prodNo + ",")) {
			prodNo = prodNo + ",";
			cart = cart.replace(prodNo, "");
		} else if(cart.contains(prodNo)) {
			cart = cart.replace(prodNo, "");
		}
		System.out.println("cart : " + cart);
		Cookie cookie = new Cookie(userId, cart);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		
		System.out.println("json/removeCart : GET 끝");
	}
}
