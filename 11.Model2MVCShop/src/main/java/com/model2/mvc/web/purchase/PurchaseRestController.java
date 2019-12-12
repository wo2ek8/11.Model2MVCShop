package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;	
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addPurchase/{prodNo}", method=RequestMethod.GET)
	public Product addPurchase(@PathVariable int prodNo) throws Exception {
		System.out.println("json/addPurchase/{prodNo} : GET 시작");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println("json/addPurchase/{prodNo} : GET 끝");
		
		return product;
	}
	
	@RequestMapping(value="json/addPurchase/{buyerId}/{prodNo}", method=RequestMethod.POST)
	public Purchase addPurchase(@PathVariable String buyerId, @PathVariable String prodNo, @RequestBody Purchase purchase, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("json/addPurchase/{buyerId}/{prodNo} : POST 시작");
		
		User user = userService.getUser(buyerId);
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setTranCode("0");
		
		purchaseService.addPurchase(purchase);
		
		Search search = new Search();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Integer totalPurchase = (Integer)map.get("totalPurchase");
		
		System.out.println("totalPurchase : " + totalPurchase);
		
		user.setPurchaseAmount(totalPurchase);
		
		userService.updateUser(user);
		
		int quantity = product.getQuantity();
		product.setQuantity(quantity - 1);
		
		productService.updateProduct(product);
		
		String userId = buyerId;
		request.setAttribute("purchase", purchase);
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
		
		System.out.println("json/addPurchase/{buyerId}/{prodNo} : POST 끝");
		
		return purchase;
	}
	
	@RequestMapping(value="json/getPurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase getPurchase(@PathVariable int tranNo) throws Exception {
		System.out.println("json/getPurchase/{tranNo} : GET 시작");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println("json/getPurchase/{tranNo} : GET 끝");
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase updatePurchase(@PathVariable int tranNo) throws Exception {
		System.out.println("json/updatePurchase/{tranNo} : GET 시작");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println("json/updatePurchase/{tranNo} : GET 끝");
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase/{tranNo}", method=RequestMethod.POST)
	public Purchase updatePurchase(@PathVariable int tranNo, @RequestBody Purchase purchase) throws Exception {
		System.out.println("json/updatePurchase/{tranNo} : POST 시작");
		
		purchaseService.updatePurchase(purchase);
		
		Purchase purchase2 = purchaseService.getPurchase(tranNo);
		
		System.out.println("json/updatePurchase/{tranNo} : POST 끝");
		
		return purchase2;
	}
	
	@RequestMapping(value="json/updateTranCode/{tranNo}/{tranCode}/{currentPage}", method=RequestMethod.GET)
	public Purchase updateTranCode(@PathVariable int tranNo, @PathVariable String tranCode, @PathVariable int currentPage, HttpServletRequest request) throws Exception {
		System.out.println("json/updateTranCode/{tranNo}/{tranCode}/{page} : GET 시작");
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		Purchase purchase2 = purchaseService.getPurchase(tranNo);
		
		System.out.println("json/updateTranCode/{tranNo}/{tranCode}/{page} : GET 끝");
		
		return purchase2;
	}
	
	@RequestMapping(value="json/listPurchase", method=RequestMethod.GET)
	public Map listPurchase(HttpServletRequest request) throws Exception {
		System.out.println("json/listPurchase : GET 시작");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		//String buyerId = user.getUserId();
		String buyerId = "user01";
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalPurchase")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		
		Map map2 = new HashMap();
		map2.put("list", map.get("list"));
		map2.put("resultPage", resultPage);
		map2.put("search", search);
		
		System.out.println("json/listPurchase : GET 끝");
		
		return map2;
	}
	
	@RequestMapping(value="json/listSale/{currentPage}", method=RequestMethod.GET)
	public Map listSale(@PathVariable String currentPage, HttpServletRequest request) throws Exception {
		System.out.println("json/listSale : GET 시작");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		if(currentPage == null || currentPage == "") {
			
		} else {
			search.setCurrentPage(Integer.parseInt(currentPage));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		
		Map map2 = new HashMap();
		map2.put("list", map.get("list"));
		map2.put("resultPage", resultPage);
		map2.put("search", search);
		
		System.out.println("json/listSale : GET 끝");
		
		return map2;
	}
}
