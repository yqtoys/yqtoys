<?php
session_start();
require_once 'db_config.php';

$logged_in = isset($_SESSION['user_id']);
$user_name = $logged_in ? $_SESSION['user_name'] : '';

// 从数据库获取商品
try {
    // 获取热门商品（按创建时间排序）
    $stmt = $pdo->query("SELECT p.*, u.first_name, u.last_name 
                         FROM products p 
                         JOIN users u ON p.seller_id = u.id 
                         WHERE p.status = 'active' 
                         ORDER BY p.created_at DESC 
                         LIMIT 8");
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // 获取新品（最近7天内发布的）
    $stmt = $pdo->query("SELECT p.*, u.first_name, u.last_name 
                         FROM products p 
                         JOIN users u ON p.seller_id = u.id 
                         WHERE p.status = 'active' 
                         AND p.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
                         ORDER BY p.created_at DESC 
                         LIMIT 8");
    $new_products = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
} catch(PDOException $e) {
    $products = [];
    $new_products = [];
    $error = "Error loading products: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEasy - Your Online Shopping Destination</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; box-shadow: 0 2px 10px rgba(255, 107, 53, 0.3); }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; align-items: center; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .welcome-text { color: white; }
        .search-area { background-color: white; padding: 25px 0; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .search-box { display: flex; width: 650px; margin: 0 auto; border-radius: 24px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); border: 2px solid #ff6b35; }
        .search-box input { flex: 1; padding: 14px 20px; border: none; outline: none; font-size: 16px; }
        .search-box button { padding: 0 30px; background-color: #ff6b35; color: white; border: none; cursor: pointer; font-size: 16px; transition: background-color 0.3s; }
        .search-box button:hover { background-color: #e55a2b; }
        .categories { background-color: white; margin-top: 20px; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .category-list { display: flex; list-style: none; justify-content: space-around; }
        .category-list li a { padding: 10px 20px; border-radius: 6px; transition: all 0.3s; display: flex; flex-direction: column; align-items: center; text-align: center; text-decoration: none; color: #333; }
        .category-list li a i { font-size: 24px; margin-bottom: 8px; color: #ff6b35; }
        .category-list li a:hover { background-color: #ff6b35; color: white; transform: translateY(-3px); }
        .category-list li a:hover i { color: white; }
        .section-title { margin: 30px 0 20px; font-size: 22px; color: #333; border-left: 4px solid #ff6b35; padding-left: 12px; }
        .products { display: flex; flex-wrap: wrap; margin-top: 10px; gap: 20px; }
        .product-card { width: 230px; background-color: white; border-radius: 8px; overflow: hidden; box-shadow: 0 3px 10px rgba(0,0,0,0.1); transition: all 0.3s; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.15); }
        .product-img { width: 100%; height: 200px; background: linear-gradient(135deg, #f8f8f8 0%, #e8e8e8 100%); display: flex; align-items: center; justify-content: center; color: #999; position: relative; overflow: hidden; }
        .product-info { padding: 15px; }
        .product-title { font-size: 14px; height: 40px; overflow: hidden; margin-bottom: 10px; }
        .product-price { color: #ff6b35; font-weight: bold; font-size: 18px; margin-top: 5px; }
        .product-seller { color: #666; font-size: 12px; margin-top: 5px; }
        .product-actions { display: flex; justify-content: space-between; margin-top: 15px; }
        .btn-cart, .btn-buy { padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px; transition: all 0.3s; }
        .btn-cart { background-color: #f8f8f8; color: #666; }
        .btn-cart:hover { background-color: #ff6b35; color: white; }
        .btn-buy { background-color: #ff6b35; color: white; }
        .btn-buy:hover { background-color: #e55a2b; }
        .empty-products { text-align: center; padding: 40px; color: #666; grid-column: 1 / -1; }
        .empty-products i { font-size: 48px; color: #ddd; margin-bottom: 15px; }
        .footer { margin-top: 50px; background-color: white; padding: 40px 0; text-align: center; color: #999; border-top: 1px solid #eee; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 20px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 1200px) { .container { width: 95%; } .product-card { width: calc(25% - 20px); } }
        @media (max-width: 992px) { .product-card { width: calc(33.333% - 20px); } }
        @media (max-width: 768px) { .product-card { width: calc(50% - 20px); } .search-box { width: 90%; } .category-list { flex-wrap: wrap; } .category-list li { margin-bottom: 10px; width: 25%; } }
        @media (max-width: 576px) { .product-card { width: 100%; } .category-list li { width: 33.333%; } .nav-links { flex-direction: column; gap: 5px; } }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="top-nav">
                <div class="logo">
                    <span class="logo-icon">🛒</span>
                    <a href="index.php" style="color: white; text-decoration: none;">ShopEasy</a>
                </div>
                <div class="nav-links">
                    <?php if ($logged_in): ?>
                        <span class="welcome-text">Welcome, <?php echo htmlspecialchars($user_name); ?>!</span>
                        <a href="user_dashboard.php"><i class="fas fa-user"></i> Dashboard</a>
                        <a href="sell_product.php"><i class="fas fa-plus"></i> Sell</a>
                        <a href="cart.php"><i class="fas fa-shopping-cart"></i> Cart</a>
                        <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    <?php else: ?>
                        <a href="login.html"><i class="fas fa-user"></i> Login</a>
                        <a href="register.html"><i class="fas fa-user-plus"></i> Register</a>
                        <a href="login.html"><i class="fas fa-store"></i> Sell</a>
                        <a href="login.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <div class="search-area">
        <div class="container">
            <div class="search-box">
                <input type="text" placeholder="Search for products...">
                <button><i class="fas fa-search"></i> Search</button>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="categories">
            <ul class="category-list">
                <li><a href="#"><i class="fas fa-mobile-alt"></i> Electronics</a></li>
                <li><a href="#"><i class="fas fa-laptop"></i> Computers</a></li>
                <li><a href="#"><i class="fas fa-tshirt"></i> Fashion</a></li>
                <li><a href="#"><i class="fas fa-home"></i> Home & Garden</a></li>
                <li><a href="#"><i class="fas fa-utensils"></i> Groceries</a></li>
                <li><a href="#"><i class="fas fa-palette"></i> Beauty</a></li>
                <li><a href="#"><i class="fas fa-running"></i> Sports</a></li>
                <li><a href="#"><i class="fas fa-book"></i> Books</a></li>
            </ul>
        </div>
        
        <h2 class="section-title">Popular Products</h2>
        <div class="products">
            <?php if (!empty($products)): ?>
                <?php foreach ($products as $product): ?>
                    <div class="product-card">
                        <div class="product-img">
                            <?php if (!empty($product['image_url'])): ?>
                                <img src="<?php echo htmlspecialchars($product['image_url']); ?>" alt="<?php echo htmlspecialchars($product['title']); ?>" style="width: 100%; height: 100%; object-fit: cover;">
                            <?php else: ?>
                                <i class="fas fa-camera" style="font-size: 48px;"></i>
                            <?php endif; ?>
                        </div>
                        <div class="product-info">
                            <div class="product-title"><?php echo htmlspecialchars($product['title']); ?></div>
                            <div class="product-price">$<?php echo number_format($product['price'], 2); ?></div>
                            <div class="product-seller">Sold by: <?php echo htmlspecialchars($product['first_name'] . ' ' . $product['last_name']); ?></div>
                            <div class="product-actions">
                                <button class="btn-cart" onclick="addToCart(<?php echo $product['id']; ?>)" class="btn-cart">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                                <button class="btn-buy" onclick="buyNow(<?php echo $product['id']; ?>)">
                                    Buy Now
                                </button>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="empty-products">
                    <i class="fas fa-box-open"></i>
                    <h3>No Products Available</h3>
                    <p>Be the first to list a product!</p>
                    <?php if ($logged_in): ?>
                        <a href="sell_product.php" style="display: inline-block; background: #ff6b35; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; margin-top: 15px;">
                            List Your Product
                        </a>
                    <?php else: ?>
                        <a href="register.html" style="display: inline-block; background: #ff6b35; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; margin-top: 15px;">
                            Join Now to Sell
                        </a>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
        
        <h2 class="section-title">New Arrivals</h2>
        <div class="products">
            <?php if (!empty($new_products)): ?>
                <?php foreach ($new_products as $product): ?>
                    <div class="product-card">
                        <div class="product-img">
                            <?php if (!empty($product['image_url'])): ?>
                                <img src="<?php echo htmlspecialchars($product['image_url']); ?>" alt="<?php echo htmlspecialchars($product['title']); ?>" style="width: 100%; height: 100%; object-fit: cover;">
                            <?php else: ?>
                                <i class="fas fa-camera" style="font-size: 48px;"></i>
                            <?php endif; ?>
                        </div>
                        <div class="product-info">
                            <div class="product-title"><?php echo htmlspecialchars($product['title']); ?></div>
                            <div class="product-price">$<?php echo number_format($product['price'], 2); ?></div>
                            <div class="product-seller">Sold by: <?php echo htmlspecialchars($product['first_name'] . ' ' . $product['last_name']); ?></div>
                            <div class="product-actions">
                                <button class="btn-cart" onclick="addToCart(<?php echo $product['id']; ?>)" class="btn-cart">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                                <button class="btn-buy" onclick="buyNow(<?php echo $product['id']; ?>)">
                                    Buy Now
                                </button>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="empty-products">
                    <i class="fas fa-clock"></i>
                    <h3>No New Products</h3>
                    <p>Check back later for new arrivals</p>
                </div>
            <?php endif; ?>
        </div>
    </div>

    <div class="footer">
        <div class="container">
            <div class="footer-links">
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Terms of Service</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Help Center</a>
            </div>
            <p>© 2023 ShopEasy Inc. | Your Trusted Online Shopping Platform</p>
        </div>
    </div>

    <script>
        function addToCart(productId) {
            <?php if ($logged_in): ?>
                alert('Adding product ' + productId + ' to cart - This feature will be implemented soon.');
                // 这里可以发送AJAX请求添加到购物车
            <?php else: ?>
                alert('Please login to add items to cart.');
                window.location.href = 'login.html';
            <?php endif; ?>
        }

        function buyNow(productId) {
            <?php if ($logged_in): ?>
                alert('Buying product ' + productId + ' - This feature will be implemented soon.');
                // 这里可以跳转到结算页面
            <?php else: ?>
                alert('Please login to purchase products.');
                window.location.href = 'login.html';
            <?php endif; ?>
        }

        // 搜索功能
        document.querySelector('.search-box button').addEventListener('click', function() {
            const searchTerm = document.querySelector('.search-box input').value;
            if (searchTerm.trim()) {
                alert('Searching for: ' + searchTerm + ' - Search feature will be implemented soon.');
            }
        });

        document.querySelector('.search-box input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.querySelector('.search-box button').click();
            }
        });
    </script>
</body>
</html>
