package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.List;

/**
 * ProductDetailServlet — Display individual product details page
 */
@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/browse");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam.trim());
            Product product = productDAO.findById(productId);

            if (product == null) {
                request.setAttribute("error", "Product not found.");
                response.sendRedirect(request.getContextPath() + "/browse");
                return;
            }

            // Check if product is featured (first 4 active products)
            List<Product> activeProducts = productDAO.getActiveProducts();
            boolean isFeatured = false;
            for (int i = 0; i < Math.min(4, activeProducts.size()); i++) {
                if (activeProducts.get(i).getId() == productId) {
                    isFeatured = true;
                    break;
                }
            }

            request.setAttribute("product", product);
            request.setAttribute("isFeatured", isFeatured);
            request.getRequestDispatcher("/user/product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/browse");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}
