package com.uglyfd.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.uglyfd.admin.model.service.ProductService;
import com.uglyfd.admin.model.vo.Product;
import com.uglyfd.admin.model.vo.ProductFile;
import com.uglyfd.admin.utill.FileRename;


@WebServlet(name = "productUpdate", urlPatterns = { "/product/update" })
public class ProductUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ProductUpdateServlet() {
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String update = request.getParameter("update");
		int productCategoryNum = Integer.parseInt(request.getParameter("productCategoryNum"));
		String productName = request.getParameter("productName");
		int productNum = Integer.parseInt(request.getParameter("productNum"));
		
		ProductFile productfile = new ProductService().findByProductFile(productNum);
		
		Product product =  new ProductService().findByProduct(productCategoryNum, productName);
		
		if (product != null) {
			request.setAttribute("productfile", productfile);
			request.setAttribute("product", product);
			request.getRequestDispatcher("/views/admin/admin_product_update.jsp").forward(request, response);
		}else {
			request.setAttribute("msg", "해당하는 상품을 찾을 수 없습니다.");
			request.setAttribute("location", "/views/admin/admin_product_detail.jsp");
			request.getRequestDispatcher("/views/common/msg.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int result = 0;
		
		String path = getServletContext().getRealPath("/resources/upload/product");
		
		int maxSize = 10485760;
		
		String encoding = "UTF-8";
		
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
		
		Product product = new Product();
		
		ProductFile productFile = new ProductFile();
		
		productFile.setProductNum(Integer.parseInt(mr.getParameter("productNum")));
		productFile.setRenamedFileName(mr.getFilesystemName("upfile"));
		productFile.setOriginalFileName(mr.getOriginalFileName("upfile"));
		
		product.setProductCategoryNum(Integer.parseInt(mr.getParameter("productCategoryNum")) );
		product.setProductName(mr.getParameter("productName"));
		product.setProductPrice(Integer.parseInt(mr.getParameter("productPrice")));
		product.setProductDetail(mr.getParameter("productDetail"));
		product.setProductNum(Integer.parseInt( mr.getParameter("productNum")));
		
		result = new ProductService().productUpdate(product,productFile);
		
		if (result > 0) {
			request.setAttribute("msg", "상품이 정상적으로 수정되었습니다.");
			request.setAttribute("location", "/views/admin/admin_product_detail.jsp");
		}else {
			request.setAttribute("msg", "상품 수정에 실패했습니다.");
			request.setAttribute("location", "/views/admin/admin_product_detail.jsp");
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}

}
