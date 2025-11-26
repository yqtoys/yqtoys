<?php
require_once 'check_login.php';
$user = getUserInfo();

// 获取购物车商品
require_once 'db_config.php';
try {
    $stmt = $pdo->prepare("
        SELECT c.*, p.title, p.description, p.price, p.image_url, p.quantity as stock 
        FROM cart c 
        JOIN products p ON c.product_id = p.id 
        WHERE c.user_id = ? AND p.status = 'active'
        ORDER BY c.created_at DESC
    ");
    $stmt->execute([$user['id']]);
    $cart_items = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // 计算总价
    $subtotal = 0;
    foreach ($cart_items as $item) {
        $subtotal += $item['price'] * $item['quantity'];
    }
    $shipping = $subtotal > 50 ? 0 : 9.99; // 满50免运费
    $tax = $subtotal * 0.08; // 8%税
    $total = $subtotal + $shipping + $tax;
    
} catch(PDOException $e) {
    $cart_items = [];
    $subtotal = 0;
    $shipping = 0;
    $tax = 0;
    $total = 0;
    $error = "Error loading cart: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - ShopEasy</title>
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
        .cart-container { display: flex; gap: 30px; margin: 30px 0; }
        .cart-items { flex: 2; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .cart-summary { flex: 1; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); height: fit-content; }
        .cart-item { display: flex; gap: 20px; padding: 20px 0; border-bottom: 1px solid #eee; }
        .item-image { width: 100px; height: 100px; background: #f8f9fa; border-radius: 5px; display: flex; align-items: center; justify-content: center; color: #999; flex-shrink: 0; }
        .item-details { flex: 1; }
        .item-title { font-weight: 600; margin-bottom: 5px; font-size: 16px; }
        .item-price { color: #ff6b35; font-weight: bold; font-size: 18px; margin-bottom: 10px; }
        .item-quantity { display: flex; align-items: center; gap: 10px; margin: 10px 0; }
        .quantity-btn { width: 30px; height: 30px; border: 1px solid #ddd; background: white; border-radius: 3px; cursor: pointer; }
        .quantity-input { width: 50px; height: 30px; border: 1px solid #ddd; border-radius: 3px; text-align: center; }
        .remove-btn { color: #dc3545; background: none; border: none; cursor: pointer; font-size: 14px; }
        .remove-btn:hover { text-decoration: underline; }
        .summary-line { display: flex; justify-content: space-between; margin: 15px 0; }
        .total { border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px; font-weight: bold; font-size: 18px; }
        .checkout-btn { background: #ff6b35; color: white; padding: 15px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 20px; }
        .checkout-btn:hover { background: #e55a2b; }
        .checkout-btn:disabled { background: #ccc; cursor: not-allowed; }
        .empty-cart { text-align: center; padding: 60px 20px; }
        .empty-cart i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .continue-shopping { background: #ff6b35; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 20px; }
        .item-total { font-weight: 600; color: #333; margin-top: 5px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .cart-container { flex-direction: column; } .cart-item { flex-direction: column; } }
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
                    <a href="cart.php"><i class="fas fa-shopping-cart"></i> Cart (<?php echo count($cart_items); ?>)</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 style="margin: 30px 0;">Shopping Cart</h1>
        
        <div class="cart-container">
            <div class="cart-items">
                <?php if (empty($cart_items)): ?>
                    <div class="empty-cart">
                        <i class="fas fa-shopping-cart"></i>
                        <h2>Your cart is empty</h2>
                        <p>Browse our products and add items to your cart</p>
                        <a href="index.php" class="continue-shopping">
                            Continue Shopping
                        </a>
                    </div>
                <?php else: ?>
                    <?php foreach ($cart_items as $item): ?>
                        <div class="cart-item" data-item-id="<?php echo $item['id']; ?>">
                            <div class="item-image">
                                <?php if (!empty($item['image_url'])): ?>
                                    <img src="<?php echo htmlspecialchars($item['image_url']); ?>" alt="<?php echo htmlspecialchars($item['title']); ?>" style="width: 100%; height: 100%; object-fit: cover; border-radius: 5px;">
                                <?php else: ?>
                                    <i class="fas fa-box"></i>
                                <?php endif; ?>
                            </div>
                            <div class="item-details">
                                <div class="item-title"><?php echo htmlspecialchars($item['title']); ?></div>
                                <div class="item-price">$<?php echo number_format($item['price'], 2); ?></div>
                                <div class="item-quantity">
                                    <label>Qty:</label>
                                    <button class="quantity-btn" onclick="updateQuantity(<?php echo $item['id']; ?>, <?php echo $item['quantity'] - 1; ?>)">-</button>
                                    <input type="text" class="quantity-input" value="<?php echo $item['quantity']; ?>" readonly>
                                    <button class="quantity-btn" onclick="updateQuantity(<?php echo $item['id']; ?>, <?php echo $item['quantity'] + 1; ?>)">+</button>
                                </div>
                                <div class="item-total">
                                    Total: $<?php echo number_format($item['price'] * $item['quantity'], 2); ?>
                                </div>
                                <button class="remove-btn" onclick="removeFromCart(<?php echo $item['id']; ?>)">
                                    <i class="fas fa-trash"></i> Remove
                                </button>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>

            <div class="cart-summary">
                <h3>Order Summary</h3>
                <div class="summary-line">
                    <span>Subtotal (<?php echo count($cart_items); ?> items):</span>
                    <span>$<?php echo number_format($subtotal, 2); ?></span>
                </div>
                <div class="summary-line">
                    <span>Shipping:</span>
                    <span><?php echo $shipping == 0 ? 'FREE' : '$' . number_format($shipping, 2); ?></span>
                </div>
                <div class="summary-line">
                    <span>Tax:</span>
                    <span>$<?php echo number_format($tax, 2); ?></span>
                </div>
                <div class="summary-line total">
                    <span>Total:</span>
                    <span>$<?php echo number_format($total, 2); ?></span>
                </div>
                <button class="checkout-btn" <?php echo empty($cart_items) ? 'disabled' : ''; ?> onclick="checkout()">
                    Proceed to Checkout
                </button>
                <?php if (empty($cart_items)): ?>
                    <p style="text-align: center; margin-top: 15px; color: #666; font-size: 14px;">Add items to cart to proceed</p>
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
        function updateQuantity(itemId, newQuantity) {
            if (newQuantity < 1) return;
            
            const formData = new FormData();
            formData.append('item_id', itemId);
            formData.append('quantity', newQuantity);
            
            fetch('update_cart.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload(); // 刷新页面更新显示
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to update quantity');
            });
        }

        function removeFromCart(itemId) {
            if (!confirm('Are you sure you want to remove this item from your cart?')) return;
            
            const formData = new FormData();
            formData.append('item_id', itemId);
            
            fetch('remove_from_cart.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload(); // 刷新页面
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to remove item');
            });
        }

        function checkout() {
            alert('Proceeding to checkout - This feature will be implemented soon.');
            // window.location.href = 'checkout.php';
        }
    </script>
</body>
</html>
