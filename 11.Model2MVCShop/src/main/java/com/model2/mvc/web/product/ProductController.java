package com.model2.mvc.web.product;

import java.awt.List;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.review.ReviewService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	// setter Method 구현 않음

	public ProductController() {
		System.out.println(this.getClass());
	}

	// ==> classpath:config/common.properties, classpath:config/commonservice.xml 참조
	// 할것
	// ==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ? : 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ? : 2}")
	int pageSize;

	private static final String UPLOAD_PATH = "C:\\Users\\User\\git\\10.Model2MVCShop-Ajax-\\10.Model2MVCShop(Ajax)\\WebContent\\images\\uploadFiles";
	
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@RequestParam("uploadFiles") ArrayList<MultipartFile> fileName, @ModelAttribute("product") Product product) throws Exception {
		 String result = "";
		 int i = 0;
		 System.out.println( "addProduct() start...");
		 for (MultipartFile files : fileName) {
			 i++;
			result = saveFile(files) + result;
			if (i != fileName.size()) {
				result = ":" + result;
			}
		}
		    System.out.println("result : " + result);
		    
		    product.setManuDate(product.getManuDate().replace("-", ""));
			product.setFileName(result);
			System.out.println("fileNameList : " + product.getFileNameList());
			
			productService.addProduct(product);
		return "forward:/product/readProduct.jsp";
	}
	  
	  
	  private String saveFile(MultipartFile file) {

//			이름 중복되지 않게 파일이름 변경
			UUID uuid = UUID.randomUUID();
			String saveName = uuid + "_" + file.getOriginalFilename();

			System.out.println("File Save Name : " + saveName);

			File saveFile = new File(UPLOAD_PATH, saveName);

			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}

			return saveName;
		}
	 

	//@RequestMapping("/addProduct.do")
//	@RequestMapping(value="addProduct", method=RequestMethod.POST)
//	public ModelAndView addProduct(@ModelAttribute("product") Product product) throws Exception {
//
//		System.out.println("/product/addProduct : POST");
//		// Business Logic
//		productService.addProduct(product);
//
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("/product/readProduct.jsp");
//
//		return modelAndView;
//	}

	/*
	//@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String
	getProduct(@RequestParam("prodNo") String prodNo, Model model,
	HttpServletRequest request, HttpServletResponse
	response, @ModelAttribute("search") Search search) throws Exception {
	  
		System.out.println("/getProduct.do"); //Business Logic
		Product product =
		productService.getProduct(Integer.parseInt(prodNo)); //Model과 View 연결
		model.addAttribute("product", product);
		  
		Cookie[] cookies = request.getCookies();
		  
		String noLine = "";
		  
		if(cookies != null) { for(int i = 0; i < cookies.length; i++) {
		if(cookies[i].getName().equals("history")) {
		  
		noLine += cookies[i].getValue(); } }
		  
		} if(noLine != "") { noLine = prodNo + "," + noLine; } else { noLine =
		prodNo; }
		  
		Cookie cookie = new Cookie("history", noLine);
		  
		cookie.setMaxAge(-1); response.addCookie(cookie);
		  
		if(search.getCurrentPage() == 0) { search.setCurrentPage(1); }
		search.setPageSize(pageSize);
		  
		Map<String, Object> map = reviewService.getReviewList(search,
		Integer.parseInt(prodNo));
		  
		Page resultPage = new Page(search.getCurrentPage(),
		((Integer)map.get("prodReview")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " + resultPage);
		  
		model.addAttribute("list", map.get("list")); model.addAttribute("resultPage",
		resultPage); model.addAttribute("search", search);
		  
		return "forward:/product/afterUpdate.jsp"; }
	 */
	 
	
	
	//@RequestMapping("/getProduct.do")
//	@RequestMapping(value="getProduct", method=RequestMethod.GET)
//	public ModelAndView getProduct(@RequestParam("prodNo") String prodNo, HttpServletRequest request,
//			HttpServletResponse response, @ModelAttribute("search") Search search) throws Exception {
//
//		System.out.println("/product/getProduct : GET");
//		// Business Logic
//		Product product = productService.getProduct(Integer.parseInt(prodNo));
//		// Model과 View 연결
//
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.addObject("product", product);
//
//		Cookie[] cookies = request.getCookies();
//
//		String noLine = "";
//
//		if (cookies != null) {
//			for (int i = 0; i < cookies.length; i++) {
//				if (cookies[i].getName().equals("history")) {
//
//					noLine += cookies[i].getValue();
//				}
//			}
//
//		}
//		if (noLine != "") {
//			noLine = prodNo + "," + noLine;
//		} else {
//			noLine = prodNo;
//		}
//
//		Cookie cookie = new Cookie("history", noLine);
//		
//		System.out.println("noLine : " + noLine);
//
//		cookie.setMaxAge(-1);
//		response.addCookie(cookie);
//		
//		
//
//		if (search.getCurrentPage() == 0) {
//			search.setCurrentPage(1);
//		}
//		search.setPageSize(pageSize);
//
//		Map<String, Object> map = reviewService.getReviewList(search, Integer.parseInt(prodNo));
//
//		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("prodReview")).intValue(), pageUnit,
//				pageSize);
//		System.out.println("resultPage : " + resultPage);
//
//		modelAndView.addObject("list", map.get("list"));
//		modelAndView.addObject("resultPage", resultPage);
//		modelAndView.addObject("search", search);
//
//		modelAndView.setViewName("/product/afterUpdate.jsp");
//
//		return modelAndView;
//	}
	
	@RequestMapping(value="getHistory", method=RequestMethod.GET)
	public ModelAndView getHistory(@RequestParam("prodNo") String prodNo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println("/product/getHistory : GET");
		// Business Logic
		
		// Model과 View 연결

		ModelAndView modelAndView = new ModelAndView();
		

		Cookie[] cookies = request.getCookies();

		String noLine = "";

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("history")) {

					noLine += cookies[i].getValue();
				}
			}

		}
		if (noLine != "") {
			noLine = prodNo + "," + noLine;
		} else {
			noLine = prodNo;
		}

		Cookie cookie = new Cookie("history", noLine);
		
		System.out.println("noLine : " + noLine);

		cookie.setMaxAge(-1);
		response.addCookie(cookie);
		
		

		

		modelAndView.setViewName("redirect:/product/getProduct?prodNo=" + prodNo);

		return modelAndView;
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") String prodNo, HttpSession session) throws Exception {

		System.out.println("/product/getProduct : GET");
		// Business Logic
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		// Model과 View 연결
		
		Search search = new Search();
		Map<String, Object> map = reviewService.getReviewList(search, Integer.parseInt(prodNo));
		
		User user = (User)session.getAttribute("user");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("user", user);
		

		modelAndView.setViewName("/product/afterUpdate.jsp");

		return modelAndView;
	}
	
	@RequestMapping(value="getHistoryList", method=RequestMethod.GET)
	public String getHistoryList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		System.out.println("history.jsp");

		request.setCharacterEncoding("euc-kr");
		response.setCharacterEncoding("euc-kr");
		String history = null;
		Cookie[] cookies = request.getCookies();
		System.out.println("cookies : " + cookies);
		
		java.util.List<Product> list = new ArrayList<Product>();
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				System.out.println("cookie : " + cookie);
				System.out.println("cookie.getName() : " + cookie.getName());
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
					System.out.println("history : " + history);
				}
			}
			if (history != null) {
				String[] h = history.split(",");
				for (int i = 0; i < h.length; i++) {
					if (!h[i].equals("null")) {
						
	
						System.out.println(h[i]);
						
						Product product = productService.getProduct(Integer.parseInt(h[i]));
						
						if(product.getQuantity() >= 1) {
							list.add(product);
						}
						
						
					}
				}
			}
		}
		
		session.setAttribute("list", list);

		return "redirect:/history.jsp";
	}

	/*
	 * @RequestMapping("/updateProductView.do") public String
	 * updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws
	 * Exception {
	 * 
	 * System.out.println("/updateProductView.do"); //Business Logic Product product
	 * = productService.getProduct(prodNo); //Model과 View 연결
	 * model.addAttribute("product", product);
	 * 
	 * return "forward:/product/updateProduct.jsp"; }
	 */

	//@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {

		System.out.println("/product/updateProduct : GET");
		// Business Logic
		Product product = productService.getProduct(prodNo);
		// Model과 View 연결

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);
		modelAndView.setViewName("/product/updateProduct.jsp");

		return modelAndView;
	}

	/*
	 * @RequestMapping("/updateProduct.do") public String
	 * updateProduct(@ModelAttribute("product") Product product, Model model,
	 * HttpSession session) throws Exception {
	 * 
	 * System.out.println("/updateProduct.do"); //Business Logic
	 * productService.updateProduct(product);
	 * 
	 * return "redirect:/getProduct.do?prodNo=" + product.getProdNo(); }
	 */

	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, HttpSession session, @RequestParam("uploadFiles") ArrayList<MultipartFile> fileName)
			throws Exception {

		System.out.println("/product/updateProduct : POST");
		// Business Logic
		
		String result = "";
		 int i = 0;
		 System.out.println( "addProduct() start...");
		 for (MultipartFile files : fileName) {
			 i++;
			result = saveFile(files) + result;
			if (i != fileName.size()) {
				result = ":" + result;
			}
		}
		    System.out.println("result : " + result);
		    
		    product.setManuDate(product.getManuDate().replace("-", ""));
			product.setFileName(result);
		
		productService.updateProduct(product);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/getProduct?prodNo=" + product.getProdNo());

		return modelAndView;
	}

	/*
	 * @RequestMapping("/listProduct.do") public String
	 * listProduct(@ModelAttribute("search") Search search, Model model,
	 * HttpServletRequest request) throws Exception {
	 * 
	 * System.out.println("/listProduct.do");
	 * 
	 * 
	 * if(search.getCurrentPage() == 0) { search.setCurrentPage(1); }
	 * 
	 * 
	 * search.setPageSize(pageSize);
	 * 
	 * //Business logic 수행 Map<String, Object> map =
	 * productService.getProductList(search);
	 * 
	 * Page resultPage = new Page(search.getCurrentPage(),
	 * ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	 * System.out.println(resultPage);
	 * 
	 * //Model과 View 연결 model.addAttribute("list", map.get("list"));
	 * model.addAttribute("resultPage", resultPage); model.addAttribute("search",
	 * search);
	 * 
	 * return "forward:/product/listProduct.jsp"; }
	 */

	//@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, HttpServletRequest request)
			throws Exception {

		
		
		System.out.println("/product/listProduct : GET / POST");

		search.setCurrentPage(1);
		String currentPage = request.getParameter("currentPage");
		if(currentPage == null || currentPage == "") {
			
		} else {
			search.setCurrentPage(Integer.parseInt(currentPage));
		}

		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);
		
		

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		// Model과 View 연결

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		System.out.println("map.get('list') : " + map.get("list"));
		System.out.println("resultPage : " + resultPage);
		System.out.println("search : " + search);
		
		
		modelAndView.setViewName("/product/listProduct.jsp");

		return modelAndView;
	}
	
	
	@RequestMapping(value="indexProductList")
	public ModelAndView indexProductList(@ModelAttribute("search") Search search, HttpServletRequest request)
			throws Exception {

		
		
		
		System.out.println("/product/indexProductList : GET / POST");

		search.setCurrentPage(1);
		String currentPage = request.getParameter("currentPage");
		if(currentPage == null || currentPage == "") {
			
		} else {
			search.setCurrentPage(Integer.parseInt(currentPage));
		}

		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);
		
		

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		// Model과 View 연결

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		System.out.println("map.get('list') : " + map.get("list"));
		System.out.println("resultPage : " + resultPage);
		System.out.println("search : " + search);
		
		
		modelAndView.setViewName("/product/indexProductList.jsp");

		return modelAndView;
	}
	
	
	
	
	
	
	

	/*
	 * @RequestMapping("/addCart.do") public String addCart(HttpServletRequest
	 * request, HttpServletResponse response) throws Exception {
	 * 
	 * System.out.println("/addCart.do");
	 * 
	 * 
	 * 
	 * String prodNo = request.getParameter("prodNo"); String userId =
	 * request.getParameter("userId"); Cookie[] cookies = request.getCookies();
	 * String cart = ""; if(cookies != null) { for(int i = 0; i < cookies.length;
	 * i++) { if(cookies[i].getName().equals(userId)) { cart +=
	 * cookies[i].getValue(); } } }
	 * 
	 * if(cart.contains(prodNo)) {
	 * 
	 * } else { if(cart != "") { cart = prodNo + "," + cart; } else { cart = prodNo;
	 * }
	 * 
	 * }
	 * 
	 * 
	 * System.out.println("cart : " + cart);
	 * 
	 * 
	 * 
	 * Cookie cookie = new Cookie(userId, cart); //cookie.setMaxAge(30*24*60*60);
	 * cookie.setMaxAge(-1); response.addCookie(cookie);
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * return "redirect:/listCart.do"; }
	 */

	//@RequestMapping("/addCart.do")
	@RequestMapping(value="addCart")
	public ModelAndView addCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/product/addCart");

		String prodNo = request.getParameter("prodNo");
		String userId = request.getParameter("userId");
		Cookie[] cookies = request.getCookies();
		String cart = "";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals(userId)) {
					cart += cookies[i].getValue();
				}
			}
		}

		if (cart.contains(prodNo)) {

		} else {
			if (cart != "") {
				cart = prodNo + "," + cart;
			} else {
				cart = prodNo;
			}

		}

		System.out.println("cart : " + cart);

		Cookie cookie = new Cookie(userId, cart);
		// cookie.setMaxAge(30*24*60*60);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/listCart");

		return modelAndView;
	}

	/*
	 * @RequestMapping("/listCart.do") public String listCart(HttpSession session,
	 * HttpServletRequest request, Model model) throws Exception { User user =
	 * (User)session.getAttribute("user"); String userId = user.getUserId();
	 * 
	 * String cart = null;
	 * 
	 * java.util.List<Product> list = new ArrayList<Product>(); Cookie[] cookies =
	 * request.getCookies(); if(cookies != null && cookies.length > 0) { for(int i =
	 * 0; i < cookies.length; i++) { Cookie cookie = cookies[i];
	 * if(cookie.getName().equals(userId)) { cart = cookie.getValue(); } }
	 * System.out.println("listCart.do cart : " + cart); if(cart != null) { String[]
	 * c = cart.split(","); System.out.println("\t\t\t c: " + c);
	 * 
	 * 
	 * for(int i = 0; i < c.length; i++) { if(!(c[i] == null) && !c[i].equals("")) {
	 * Product product = productService.getProduct(Integer.parseInt(c[i]));
	 * System.out.println("\t\t\t product : " + product);
	 * 
	 * 
	 * list.add(product); } } } }
	 * 
	 * session.setAttribute("list", list);
	 * 
	 * System.out.println("list : " + list);
	 * 
	 * return "redirect:/product/listCart.jsp"; }
	 */

	//@RequestMapping("/listCart.do")
	@RequestMapping(value="listCart")
	public ModelAndView listCart(HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("/product/listCart");
		
		User user = (User) session.getAttribute("user");
		String userId = user.getUserId();

		String cart = null;

		java.util.List<Product> list = new ArrayList<Product>();
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals(userId)) {
					cart = cookie.getValue();
				}
			}
			System.out.println("/product/listCart cart : " + cart);
			if (cart != null) {
				String[] c = cart.split(",");
				System.out.println("\t\t\t c: " + c);

				for (int i = 0; i < c.length; i++) {
					if (!(c[i] == null) && !c[i].equals("")) {
						Product product = productService.getProduct(Integer.parseInt(c[i]));
						System.out.println("\t\t\t product : " + product);
						
						if(product.getQuantity() >= 1) {
							list.add(product);
						}
						
					}
				}
			}
		}

		session.setAttribute("list", list);

		System.out.println("list : " + list);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/listCart.jsp");

		return modelAndView;
	}

	/*
	 * @RequestMapping("/removeCart.do") public String removeCart(HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) throws Exception
	 * {
	 * 
	 * System.out.println("/removeCart.do");
	 * 
	 * 
	 * 
	 * String prodNo = request.getParameter("prodNo"); User user =
	 * (User)session.getAttribute("user"); String userId = user.getUserId();
	 * Cookie[] cookies = request.getCookies(); String cart = ""; if(cookies !=
	 * null) { for(int i = 0; i < cookies.length; i++) {
	 * if(cookies[i].getName().equals(userId)) { cart += cookies[i].getValue(); } }
	 * } System.out.println("cart : " + cart); if(cart.contains(prodNo + ",")) {
	 * prodNo = prodNo + ","; cart = cart.replace(prodNo, ""); } else
	 * if(cart.contains(prodNo)) { cart = cart.replace(prodNo, ""); }
	 * System.out.println("cart : " + cart); Cookie cookie = new Cookie(userId,
	 * cart); cookie.setMaxAge(-1); response.addCookie(cookie); return
	 * "redirect:/listCart.do"; }
	 */

	//@RequestMapping("/removeCart.do")
	@RequestMapping(value="removeCart")
	public ModelAndView removeCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		System.out.println("/product/removeCart : POST");

		String prodNo = request.getParameter("prodNo");
		User user = (User) session.getAttribute("user");
		String userId = user.getUserId();
		Cookie[] cookies = request.getCookies();
		String cart = "";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals(userId)) {
					cart += cookies[i].getValue();
				}
			}
		}
		System.out.println("cart : " + cart);
		if (cart.contains(prodNo + ",")) {
			prodNo = prodNo + ",";
			cart = cart.replace(prodNo, "");
		} else if (cart.contains(prodNo)) {
			cart = cart.replace(prodNo, "");
		}
		System.out.println("cart : " + cart);
		Cookie cookie = new Cookie(userId, cart);
		cookie.setMaxAge(-1);
		response.addCookie(cookie);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/listCart");
		return modelAndView;
	}

}
