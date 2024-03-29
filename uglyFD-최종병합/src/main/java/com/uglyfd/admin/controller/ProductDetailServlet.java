package com.uglyfd.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.uglyfd.admin.model.service.ProductService;
import com.uglyfd.admin.model.vo.InOut;
import com.uglyfd.admin.model.vo.PageInfo;
import com.uglyfd.admin.model.vo.Product;
import com.uglyfd.admin.model.vo.ProductFile;
import com.uglyfd.admin.model.vo.Review;
import com.uglyfd.member.model.vo.Member;

@WebServlet(name = "productdetail", urlPatterns = { "/product/detail" })
public class ProductDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProductDetailServlet() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			ProductFile productFile = null;
			Product product = null;
			
			HttpSession session = ((HttpServletRequest)request).getSession(false);
			Member loginMember = (Member)(session.getAttribute("loginMember"));
			
    		int productNum = Integer.parseInt(request.getParameter("productNum"));
    		
    		productFile = new ProductService().findByProductFile(productNum);
    		product = new ProductService().findByProduct(productNum);
    		
    		request.setAttribute("loginMember", loginMember);
    		request.setAttribute("productFile", productFile);
    		request.setAttribute("product", product);
    		
    		request.getRequestDispatcher("/views/admin/product_detail_page.jsp").forward(request, response);
    		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
