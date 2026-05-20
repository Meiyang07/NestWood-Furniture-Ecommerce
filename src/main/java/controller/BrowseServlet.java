package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

/**
 * BrowseServlet — public product browsing for guests AND logged-in users.
 * Accessible at /browse (guest-safe public route).
 * /user/browse redirects to /browse so old links still work.
 */
@WebServlet({"/browse", "/user/browse"})
public class BrowseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isLoggedIn = SessionUtil.isLoggedIn(request);

        try {
            ProductDAO productDAO = new ProductDAO();
            List<Product> products;

            // Get filter parameters
            String keyword = request.getParameter("keyword");
            if (keyword == null || keyword.trim().isEmpty()) {
                keyword = request.getParameter("search");
            }
            
            String categoryParam = request.getParameter("category");
            String minPriceParam = request.getParameter("minPrice");
            String maxPriceParam = request.getParameter("maxPrice");
            String inStockParam = request.getParameter("inStock");

            Integer categoryId = null;
            Double minPrice = null;
            Double maxPrice = null;
            Boolean inStockOnly = false;

            // Parse filter parameters
            if (categoryParam != null && !categoryParam.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    // Invalid category ID, ignore
                }
            }

            if (minPriceParam != null && !minPriceParam.trim().isEmpty()) {
                try {
                    minPrice = Double.parseDouble(minPriceParam);
                } catch (NumberFormatException e) {
                    // Invalid price, ignore
                }
            }

            if (maxPriceParam != null && !maxPriceParam.trim().isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(maxPriceParam);
                } catch (NumberFormatException e) {
                    // Invalid price, ignore
                }
            }

            if ("true".equalsIgnoreCase(inStockParam)) {
                inStockOnly = true;
            }

            // Apply filters
            if (keyword != null && !keyword.trim().isEmpty()) {
                products = productDAO.searchProducts(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else {
                products = productDAO.getAllProducts();
            }

            // Apply category filter
            if (categoryId != null) {
                final Integer finalCategoryId = categoryId;
                products = products.stream()
                        .filter(p -> p.getCategoryId() == finalCategoryId)
                        .toList();
            }

            // Apply price range filter
            if (minPrice != null) {
                final Double finalMinPrice = minPrice;
                products = products.stream()
                        .filter(p -> p.getPrice() >= finalMinPrice)
                        .toList();
            }

            if (maxPrice != null) {
                final Double finalMaxPrice = maxPrice;
                products = products.stream()
                        .filter(p -> p.getPrice() <= finalMaxPrice)
                        .toList();
            }

            // Apply stock filter
            if (inStockOnly) {
                products = products.stream()
                        .filter(p -> p.getStock() > 0)
                        .toList();
            }

            // Get all categories for filter sidebar
            List<Category> categories = productDAO.getAllCategories();

            // Get featured product IDs (first 4 active products)
            List<Product> activeProducts = productDAO.getActiveProducts();
            List<Integer> featuredProductIds = activeProducts.stream()
                    .limit(4)
                    .map(Product::getId)
                    .toList();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("featuredProductIds", featuredProductIds);
            request.setAttribute("isLoggedIn", isLoggedIn);

            // Guest message
            if (!isLoggedIn) {
                request.setAttribute("guestMessage", "Browse our collection. Login to place orders and save wishlist.");
            }

            request.getRequestDispatcher("/user/browse.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}