<?php
require_once 'check_login.php';
$user = getUserInfo();

// 获取用户的订单
require_once 'db_config.php';
try {
    // 获取用户订单
    $stmt = $pdo->prepare("
        SELECT o.*, 
               COUNT(oi.id) as item_count,
               SUM(oi.quantity * oi.price) as order_total
        FROM orders o 
        LEFT JOIN order_items oi ON o.id = oi.order_id 
        WHERE o.user_id = ? 
        GROUP BY o.id 
        ORDER BY o.created_at DESC
    ");
    $stmt->execute([$user['id']]);
    $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // 获取订单详情（如果需要显示商品信息）
    $order_items = [];
    foreach ($orders as $order) {
        $stmt = $pdo->prepare("
            SELECT oi.*, p.title, p.image_url 
            FROM order_items oi 
            JOIN products p ON oi.product_id = p.id 
            WHERE oi.order_id = ?
        ");
        $stmt->execute([$order['id']]);
        $order_items[$order['id']] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
} catch(PDOException $e) {
    $orders = [];
    $order_items = [];
    $error = "Error loading orders: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - ShopEasy</title>
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
        .page-header { margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        .order-card { border: 1px solid #eee; border-radius: 10px; padding: 25px; margin-bottom: 20px; background: white; }
        .order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .order-id { font-weight: 600; color: #333; font-size: 18px; }
        .order-date { color: #666; }
        .order-status { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #d4edda; color: #155724; }
        .status-delivered { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        .order-items { margin-bottom: 15px; }
        .order-item { display: flex; gap: 15px; padding: 12px 0; border-bottom: 1px solid #f8f9fa; }
        .order-item:last-child { border-bottom: none; }
        .item-image { width: 60px; height: 60px; background: #f8f9fa; border-radius: 5px; display: flex; align-items: center; justify-content: center; color: #999; flex-shrink: 0; }
        .item-details { flex: 1; }
        .item-title { font-weight: 500; margin-bottom: 5px; }
        .item-price { color: #666; font-size: 14px; }
        .item-quantity { color: #999; font-size: 13px; }
        .order-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 15px; padding-top: 15px; border-top: 2px solid #eee; }
        .order-total { font-weight: 600; font-size: 18px; color: #ff6b35; }
        .btn-track { background: #ff6b35; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
        .btn-track:hover { background: #e55a2b; }
        .btn-review { background: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; margin-left: 10px; }
        .btn-review:hover { background: #218838; }
        .empty-state { text-align: center; padding: 60px 20px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .order-actions { display: flex; gap: 10px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-bottom: 25px; }
        .stat-card { background: #f8f9fa; padding: 15px; border-radius: 8px; text-align: center; border-left: 4px solid #ff6b35; }
        .stat-number { font-size: 24px; font-weight: bold; color: #ff6b35; }
        .stat-label { color: #666; font-size: 13px; margin-top: 5px; }
        @media (max-width: 768px) { 
            .container { width: 95%; } 
            .dashboard { flex-direction: column; } 
            .sidebar { width: 100%; } 
            .order-header { flex-direction: column; align-items: flex-start; gap: 10px; } 
            .order-footer { flex-direction: column; gap: 15px; align-items: flex-start; }
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
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
                    <li><a href="my_products.php"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.php"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.php" class="active"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.php"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.php"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.php"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-header">
                    <h1>My Orders</h1>
                    <p>View and manage your purchase history</p>
                </div>

                <?php if (isset($error)): ?>
                    <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                        <?php echo htmlspecialchars($error); ?>
                    </div>
                <?php endif; ?>

                <!-- 订单统计 -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number"><?php echo count($orders); ?></div>
                        <div class="stat-label">Total Orders</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number"><?php echo count(array_filter($orders, function($order) { return $order['status'] == 'pending'; })); ?></div>
                        <div class="stat-label">Pending</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number"><?php echo count(array_filter($orders, function($order) { return $order['status'] == 'shipped'; })); ?></div>
                        <div class="stat-label">Shipped</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number"><?php echo count(array_filter($orders, function($order) { return $order['status'] == 'delivered'; })); ?></div>
                        <div class="stat-label">Delivered</div>
                    </div>
                </div>

                <?php if (empty($orders)): ?>
                    <div class="empty-state">
                        <i class="fas fa-shopping-bag"></i>
                        <h2>No Orders Yet</h2>
                        <p>Your order history will appear here once you make a purchase</p>
                        <a href="index.php" class="btn-track" style="margin-top: 20px; display: inline-block; text-decoration: none;">
                            Start Shopping
                        </a>
                    </div>
                <?php else: ?>
                    <?php foreach ($orders as $order): ?>
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <div class="order-id">Order #<?php echo $order['id']; ?></div>
                                    <div class="order-date">Placed on <?php echo date('F j, Y g:i A', strtotime($order['created_at'])); ?></div>
                                </div>
                                <div class="order-status status-<?php echo $order['status']; ?>">
                                    <?php echo ucfirst($order['status']); ?>
                                </div>
                            </div>
                            
                            <div class="order-items">
                                <?php if (isset($order_items[$order['id']])): ?>
                                    <?php foreach ($order_items[$order['id']] as $item): ?>
                                        <div class="order-item">
                                            <div class="item-image">
                                                <?php if (!empty($item['image_url'])): ?>
                                                    <img src="<?php echo htmlspecialchars($item['image_url']); ?>" alt="<?php echo htmlspecialchars($item['title']); ?>" style="width: 100%; height: 100%; object-fit: cover; border-radius: 5px;">
                                                <?php else: ?>
                                                    <i class="fas fa-box"></i>
                                                <?php endif; ?>
                                            </div>
                                            <div class="item-details">
                                                <div class="item-title"><?php echo htmlspecialchars($item['title']); ?></div>
                                                <div class="item-price">$<?php echo number_format($item['price'], 2); ?> x <?php echo $item['quantity']; ?></div>
                                                <div class="item-quantity">Subtotal: $<?php echo number_format($item['price'] * $item['quantity'], 2); ?></div>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <p>No items found for this order.</p>
                                <?php endif; ?>
                            </div>
                            
                            <div class="order-footer">
                                <div class="order-total">Total: $<?php echo number_format($order['order_total'] ?? 0, 2); ?></div>
                                <div class="order-actions">
                                    <?php if ($order['status'] == 'shipped'): ?>
                                        <button class="btn-track" onclick="trackOrder(<?php echo $order['id']; ?>)">
                                            <i class="fas fa-shipping-fast"></i> Track Order
                                        </button>
                                    <?php endif; ?>
                                    <?php if ($order['status'] == 'delivered'): ?>
                                        <button class="btn-review" onclick="leaveReview(<?php echo $order['id']; ?>)">
                                            <i class="fas fa-star"></i> Leave Review
                                        </button>
                                    <?php endif; ?>
                                    <button class="btn-track" onclick="viewOrderDetails(<?php echo $order['id']; ?>)">
                                        <i class="fas fa-eye"></i> View Details
                                    </button>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
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
        function trackOrder(orderId) {
            alert('Tracking order #' + orderId + ' - This feature will be implemented soon.');
        }

        function leaveReview(orderId) {
            alert('Leaving review for order #' + orderId + ' - This feature will be implemented soon.');
        }

        function viewOrderDetails(orderId) {
            alert('Viewing details for order #' + orderId + ' - This feature will be implemented soon.');
            // 这里可以跳转到订单详情页面：window.location.href = 'order_details.php?id=' + orderId;
        }
    </script>
</body>
</html>
