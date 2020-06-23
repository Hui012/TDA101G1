package com.customerize.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.OptionalDouble;
import java.util.Set;
import java.util.TreeMap;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.customerize.model.CustomerizeService;
import com.customerize.model.CustomerizeVO;
import com.customerizedetail.model.CustDetailService;
import com.customerizedetail.model.CustDetailVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.product.controller.JedisShoppingCar;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;

@WebServlet("/project/JsonController")
public class JsonController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");
		res.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = res.getWriter();
//		System.out.println("進來了 JsonController");

		String action = req.getParameter("action");
//		System.out.println(action);

		/*==============================依使用者所選的地點、類別篩選產品==============================*/	
		if (action.equals("load_product")) {
			ProductService productDao = new ProductService();
			ProductCmtService productCmtDao = new ProductCmtService();
			List<ProductVO> listProducts = productDao.getAll();
			List<ProductCmtVO> listProductCmts = productCmtDao.getAll();
			String selected_class = req.getParameter("selected_class");
			String selected_county = req.getParameter("selected_county");
			String[] class_options = null;
			String[] county_options = null;
			if (selected_class != null && selected_class.length() != 0) {
				class_options = jsonArrayToStringArray(selected_class);
			}
			if (selected_county != null && selected_county.length() != 0) {
				county_options = jsonArrayToStringArray(selected_county);
			}
			List<String> product_class = Arrays.asList(class_options);
			List<String> product_county = Arrays.asList(county_options);
			List<ProductVO> filter_products = listProducts.stream()
					.filter(p -> product_class.contains(p.getProduct_Class()))
					.filter(p -> product_county.contains(p.getProduct_County()))
					.collect(Collectors.toList());
			
			Map<String, Double> groupMap_avg = listProductCmts.stream()
					.collect(Collectors.groupingBy(ProductCmtVO::getProduct_ID
							, Collectors.averagingDouble(ProductCmtVO::getProduct_Cmt_Grade)));
			
			Map<String, Long> groupMap_count = listProductCmts.stream()
					.collect(Collectors.groupingBy(ProductCmtVO::getProduct_ID
							, Collectors.counting()));
							
//			System.out.println(groupMap_avg.keySet());	
			for(ProductVO filter_product :filter_products) {
				ProductCmtVO productCmtVO = new ProductCmtVO();
				for(String key : groupMap_avg.keySet()) {
					if(filter_product.getProduct_ID().equals(key)) {
						productCmtVO.setProduct_Cmt_Grade(groupMap_avg.get(key));
						productCmtVO.setCount(groupMap_count.get(key));
						filter_product.setProductCmtVO(productCmtVO);
					}
				}
				if(filter_product.getProductCmtVO() == null) {
					productCmtVO.setProduct_Cmt_Grade(0.0);
					productCmtVO.setCount(0L);
					filter_product.setProductCmtVO(productCmtVO);
				}
//				System.out.println("最後的 = " + filter_product.getProductCmtVO());
			}
							
			Map<String, List<ProductVO>> products = new HashMap<>();
			if(filter_products.size() != 0 && !filter_products.isEmpty()) {							
				products.put("products", filter_products);					//查詢有資料時回傳
			}else {
				products.put("checkBox_no_result", filter_products);		//查詢不到資料時回傳
			}
			JSONObject json = new JSONObject(products);
			out.println(json);
//			System.out.println(json);
			
//			for(ProductVO filter_product : filter_products) {
//			ProductCmtVO productCmt = new ProductCmtVO(); 
//			OptionalDouble avg = listProductCmts.stream()
//					.filter(p -> p.getProduct_ID().equals(filter_product.getProduct_ID()))
//					.mapToDouble(p -> p.getProduct_Cmt_Grade())
//					.average();
//			Long count = listProductCmts.stream()
//					.filter(p -> p.getProduct_ID().equals(filter_product.getProduct_ID()))
//					.count();
//			productCmt.setCount(count);
//			if(avg.isPresent()) {
//				double avgResult = avg.getAsDouble();
//				productCmt.setProduct_Cmt_Grade(avgResult);
//			}else {
//				productCmt.setProduct_Cmt_Grade(0.0);
//			}
//			filter_product.setProductCmtVO(productCmt);
//		}
		}
			
		/*==============================載入單個產品的評價==============================*/		
		if(action.equals("load_productCmt")) {
			String product_id = req.getParameter("product_id");
			MemberService memberDao = new MemberService();
			List<ProductCmtVO> listProductCmts = new ArrayList<>();
			List<MemberVO> listMembers = memberDao.getAll();
			if(product_id.length() != 0 && product_id != null) {
				ProductCmtService dao = new ProductCmtService();
				ProductCmtVO cmtVO = new ProductCmtVO();
				cmtVO.setProduct_ID(product_id);
				listProductCmts = dao.select_by_product(cmtVO);
			}
			List<String> member_id = listProductCmts.stream()
					.map(m -> m.getMember_ID())
					.collect(Collectors.toList());
			List<MemberVO> members = listMembers.stream()
					.filter(m -> member_id.contains(m.getMember_ID()))
					.distinct()
					.collect(Collectors.toList());  //.collect(Collectors.toSet());
//			members.forEach(System.out::println);
				
			for(ProductCmtVO listProductCmt : listProductCmts) {
				for(MemberVO member : members) {
					if(listProductCmt.getMember_ID().equals(member.getMember_ID())) {
						listProductCmt.setMemberVO(member);
					}
				}
			}
//			listProductCmts.forEach(System.out::println);
			Map<String, List<ProductCmtVO>> product_cmt = new HashMap<>();
			product_cmt.put("product_cmt", listProductCmts);
			JSONObject json = new JSONObject(product_cmt);
			out.println(json);
//			System.out.println(listProductCmts);
		}
			

		/*==============================insert行程細節==============================*/	
		if (action.equals("insert_schedule")) {
			try {
				CustomerizeService customerizeDao = new CustomerizeService();
				CustDetailService custDetailDao = new CustDetailService();
				ProductService productDao = new ProductService();
				CustomerizeVO customerizeVO = new CustomerizeVO();
				ProductVO productVO = new ProductVO();
				Map<String, List<CustDetailVO>> details = new HashMap<>();
				List<CustDetailVO> CustDetailVOs = new ArrayList<>();
				String cust_schedule_data = req.getParameter("cust_schedule_data");
				String cust_schedule_detail_data = req.getParameter("cust_schedule_detail_data");
				System.out.println("cust_schedule_data = " +cust_schedule_data);
				System.out.println("cust_schedule_detail_data = " +cust_schedule_detail_data);
				JSONObject jsonObj_master = new JSONObject(cust_schedule_data);
				JSONArray jsonArray_detail = new JSONArray(cust_schedule_detail_data);
				JSONObject obj_master = jsonObj_master.getJSONObject("cust_schedule_data"); // 再取裡面的key為cust_schedule_data的Object
				String cust_schedule_id = obj_master.getString("cust_schedule_id");
				String title = obj_master.getString("title");
				String first_day = obj_master.getString("first_day");
				String last_day = obj_master.getString("last_day");
				String total_day = obj_master.getString("total_day");
				
				if (cust_schedule_id != null && cust_schedule_id.length() != 0) {
					CustDetailVO bean = new CustDetailVO();
					bean.setCust_Schedule_ID(cust_schedule_id);
					boolean result = custDetailDao.delete(bean);
					System.out.println("delete : " + result);
				}
				
				String product_id = "";
				for (int i = 0; i < jsonArray_detail.length(); i++) {
					if (jsonArray_detail.get(i).equals(null) || !(jsonArray_detail.get(i) instanceof org.json.JSONArray)) {
						continue;
					}
					JSONArray jsonArray_detail2 = (JSONArray) jsonArray_detail.get(i);
					for (int j = 0; j < jsonArray_detail2.length(); j++) {
						JSONObject json_obj = jsonArray_detail2.getJSONObject(j);
						CustDetailVO bean = new CustDetailVO(); // 記得要驗證
						if(i == 0 && j == 0) {
							product_id = json_obj.getString("product_ID");
							if(product_id.length() != 0) {
								productVO.setProduct_ID(product_id);
								customerizeVO.setCust_Schedule_ID(cust_schedule_id);  // 先select這個ID的值
								customerizeVO = customerizeDao.select(customerizeVO);  //傳回選擇的VO
								customerizeVO.setCust_Schedule_Name(title); // 再把剛從JSON取出的值塞進去
								customerizeVO.setCust_Schedule_Start_Time(Date.valueOf(first_day));
								customerizeVO.setCust_Schedule_End_Time(Date.valueOf(last_day));
								customerizeVO.setCust_Schedule_Total_Day(Integer.parseInt(total_day));
								customerizeVO.setCust_Schedule_Img(productDao.select(productVO).getProduct_Img1());
								customerizeDao.update(customerizeVO);
							}
						}
						bean.setProduct_ID(json_obj.getString("product_ID"));
						bean.setCust_Schedule_Detail_Info(json_obj.getString("schedule_info"));
						bean.setCust_Schedule_ID(cust_schedule_id);
						bean.setCust_Schedule_Detail_Seq(Integer.parseInt(json_obj.getString("sort")));
						bean.setCust_Schedule_Detail_Date(Date.valueOf(json_obj.getString("date")));

						CustDetailVO result = new CustDetailVO();
						result = custDetailDao.insert(bean);
						CustDetailVOs.add(result);
						details.put("result", CustDetailVOs);
					}
				}
				JSONObject json = new JSONObject(details);
				out.println(json);
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		
		/*==============================載入使用者的行程細節==============================*/	
		if(action.equals("load_schedule")) {
			String cust_schedule_id = req.getParameter("cust_schedule_id");
			String selected_county = req.getParameter("selected_county");
			Map<String, String[]> map = new TreeMap<>();
			String[] str = null;
			if(cust_schedule_id.length() != 0 && cust_schedule_id != null) {
				map.put("cust_schedule_id", new String[] {cust_schedule_id});
			}
			
			if(selected_county.length() != 0 && selected_county != null) {
				str =  jsonArrayToStringArray(selected_county);
				map.put("product_county", str);
			}
			
			Map<String, List<CustDetailVO>> allCustDetails = new TreeMap<>();
			CustDetailService dao = new CustDetailService();
			List<CustDetailVO> custDetails = dao.get_detail_join_product(map);
			if(custDetails.size() != 0 && !custDetails.isEmpty()) {			
				allCustDetails.put("userSchedule", custDetails);					//查詢有資料時回傳
			}else {
				allCustDetails.put("userSchedule_no_result", custDetails);		//查詢不到資料時回傳
			}
//			System.out.println(custDetails);
			JSONObject json = new JSONObject(allCustDetails);
			out.println(json);

		}
		
		/*==============================搜尋欄位==============================*/	
		if (action.equals("searchData")) {
			String query = req.getParameter("query");
			if(query != null && query.trim().length() != 0) {
//				System.out.println(query);
				ProductService productDao = new ProductService();
				ProductCmtService cmtDao = new ProductCmtService();
				List<ProductVO> products = productDao.searchData(query);
				List<ProductCmtVO> listProductCmts = cmtDao.getAll();
				
				for(ProductVO product : products) {
					ProductCmtVO productCmt = new ProductCmtVO();
					OptionalDouble avg = listProductCmts.stream()
							.filter(p -> p.getProduct_ID().equals(product.getProduct_ID()))
							.mapToDouble(p -> p.getProduct_Cmt_Grade())
							.average();
					Long countResult = listProductCmts.stream()
							.filter(p -> p.getProduct_ID().equals(product.getProduct_ID()))
							.count();
					productCmt.setCount(countResult);
					if(avg.isPresent()) {
						double avgResult = avg.getAsDouble();
						productCmt.setProduct_Cmt_Grade(avgResult);
					}else {
						productCmt.setProduct_Cmt_Grade(0.0);
					}
					product.setProductCmtVO(productCmt);
				}
				
				Map<String, List<ProductVO>> searchResult = new HashMap<>();
				if(products.size() != 0 && !products.isEmpty()) {
					searchResult.put("products", products);
				}else {
					searchResult.put("checkBox_no_result", products);
				}
				JSONObject json = new JSONObject(searchResult);
				out.println(json);
			}
		}
		
		/*==============================加入購物車==============================*/	
		if("add_cart".equals(action)) {
			String cart_list = req.getParameter("cart_list");
			JSONArray array = new JSONArray(cart_list);
			for(int i = 0; i < array.length(); i++) {
				JSONObject obj = array.getJSONObject(i);
				if(!obj.getString("productDetail_ID").equals("null")) {        //前端有先判斷如不需票券的為"null"
					String member_ID = obj.getString("member_ID");
					String product_ID = obj.getString("product_ID");
					String product_Name = obj.getString("product_Name");
					String productDetail_ID = obj.getString("productDetail_ID");
					String quantity = obj.getString("quantity");
					String spc = obj.getString("spc");
					String start = obj.getString("start");
					String end = obj.getString("start");
					String price = obj.getString("price");
					JedisShoppingCar shoppingCar = new JedisShoppingCar();
					shoppingCar.add(member_ID, product_ID, product_Name, productDetail_ID, quantity, spc, start, end, price);
				}
			}
			out.println(new JSONObject().put("result", "success"));
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	
	public String[] jsonArrayToStringArray(String jsonArray) {
		String[] str = null;
		try {
			JSONArray array = new JSONArray(jsonArray);
			str = new String[array.length()];
			for (int i = 0; i < array.length(); i++) {
				str[i] = (String) array.get(i);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return str;
	}
	
	public List<String> jsonArrayToStringList(String jsonArray) {
		List<String> list = new ArrayList<String>();
		try {
			JSONArray array = new JSONArray(jsonArray);
			for (int i = 0; i < array.length(); i++) {
				list.add((String) array.get(i));
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return list;
	}

}
