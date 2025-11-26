<?php
require_once 'check_login.php';
$user = getUserInfo();

// 获取用户的商品
require_once 'db_config.php';
try {
    $stmt = $pdo->prepare("SELECT * FROM products WHERE seller_id = ? ORDER BY created_at DESC");
    $stmt->execute([$user['id']]);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch(PDOException $e) {
    $products = [];
    $error = "Error loading products: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Products - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; align-items: center; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .welcome-text { color: white; }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        .btn-primary { background: #ff6b35; color: white; padding: 12px 25px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; text-decoration: none; display: inline-block; }
        .btn-primary:hover { background: #e55a2b; }
        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 25px; }
        .product-card { border: 1px solid #eee; border-radius: 10px; overflow: hidden; transition: all 0.3s; position: relative; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .product-image { width: 100%; height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #999; }
        .product-info { padding: 20px; }
        .product-title { font-weight: 600; margin-bottom: 10px; font-size: 16px; height: 40px; overflow: hidden; }
        .product-price { color: #ff6b35; font-weight: bold; font-size: 18px; margin-bottom: 10px; }
        .product-meta { display: flex; justify-content: space-between; color: #666; font-size: 14px; margin-bottom: 15px; }
        .product-description { color: #666; font-size: 14px; margin-bottom: 15px; height: 60px; overflow: hidden; }
        .product-actions { display: flex; gap: 10px; }
        .btn-edit { background: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; flex: 1; }
        .btn-delete { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; flex: 1; }
        .empty-state { text-align: center; padding: 60px 20px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .status-badge { position: absolute; top: 10px; right: 10px; padding: 5px 10px; border-radius: 15px; font-size: 12px; font-weight: 600; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } .products-grid { grid-template-columns: 1fr; } .page-header { flex-direction: column; gap: 15px; align-items: flex-start; } }
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
                    <span class="welcome-text">Welcome, <?php echo htmlspecialchars($user['name']); ?>!</span>
                    <a href="user_dashboard.php"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.php"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.php"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.php"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.php"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.php" class="active"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.php"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.php"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.php"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.php"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.php"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-header">
                    <h1>My Products</h1>
                    <a href="sell_product.php" class="btn-primary">
                        <i class="fas fa-plus"></i> Add New Product
                    </a>
                </div>

                <?php if (isset($error)): ?>
                    <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                        <?php echo htmlspecialchars($error); ?>
                    </div>
                <?php endif; ?>

                <?php if (empty($products)): ?>
                    <div class="empty-state">
                        <i class="fas fa-box-open"></i>
                        <h2>No Products Yet</h2>
                        <p>Start selling by listing your first product</p>
                        <a href="sell_product.php" class="btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-plus"></i> List Your First Product
                        </a>
                    </div>
                <?php else: ?>
                    <div class="products-grid">
                        <?php foreach ($products as $product): ?>
                            <div class="product-card">
                                <div class="status-badge status-<?php echo $product['status']; ?>">
                                    <?php echo ucfirst($product['status']); ?>
                                </div>
                                <div class="product-image">
                                    <?php if (!empty($product['image_url'])): ?>
                                        <img src="<?php echo htmlspecialchars($product['image_url']); ?>" alt="<?php echo htmlspecialchars($product['title']); ?>" style="width: 100%; height: 100%; object-fit: cover;">
                                    <?php else: ?>
                                        <i class="fas fa-camera" style="font-size: 48px;"></i>
                                    <?php endif; ?>
                                </div>
                                <div class="product-info">
                                    <div class="product-title"><?php echo htmlspecialchars($product['title']); ?></div>
                                    <div class="product-price">$<?php echo number_format($product['price'], 2); ?></div>
                                    <div class="product-description">
                                        <?php echo htmlspecialchars(substr($product['description'], 0, 100)); ?><?php echo strlen($product['description']) > 100 ? '...' : ''; ?>
                                    </div>
                                    <div class="product-meta">
                                        <span>Stock: <?php echo $product['quantity']; ?></span>
                                        <span>Listed: <?php echo date('M j, Y', strtotime($product['created_at'])); ?></span>
                                    </div>
                                    <div class="product-actions">
                                        <button class="btn-edit" onclick="editProduct(<?php echo $product['id']; ?>)">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn-delete" onclick="deleteProduct(<?php echo $product['id']; ?>)">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                    
                    <div style="margin-top: 30px; text-align: center;">
                        <p>Total Products: <strong><?php echo count($products); ?></strong></p>
                    </div>
                <?php endif; ?>
            </div>
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
        function editProduct(productId) {
            alert('Edit product ' + productId + ' - This feature will be implemented soon.');
            // 这里可以跳转到编辑页面：window.location.href = 'edit_product.php?id=' + productId;
        }

        function deleteProduct(productId) {
            if (confirm('Are you sure you want to delete this product? This action cannot be undone.')) {
                // 这里可以发送AJAX请求删除商品
                fetch('delete_product.php?id=' + productId, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Product deleted successfully!');
                        location.reload();
                    } else {
                        alert('Error deleting product: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('Error deleting product. Please try again.');
                    console.error('Error:', error);
                });
            }
        }
    </script>
</body>
</html>
