#!/bin/bash

# 商品发布页面（PHP版本）
cat > sell_product.php << 'SELLEOF'
<?php
require_once 'check_login.php';
$user = getUserInfo();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Product - ShopEasy</title>
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
        .sell-container { max-width: 800px; margin: 30px auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 20px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        textarea.form-control { min-height: 120px; resize: vertical; }
        .btn-submit { background: #ff6b35; color: white; padding: 15px 30px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; width: 100%; }
        .btn-submit:hover { background: #e55a2b; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="top-nav">
                <div class="logo">
                    <span class="logo-icon">🛒</span>
                    <a href="index.html" style="color: white; text-decoration: none;">ShopEasy</a>
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
        <div class="sell-container">
            <h1 style="text-align: center; margin-bottom: 30px; color: #333;">Sell Your Product</h1>
            
            <form id="sellForm" action="sell_product_handler.php" method="POST">
                <div class="form-group">
                    <label for="productTitle">Product Title *</label>
                    <input type="text" id="productTitle" name="productTitle" class="form-control" placeholder="Enter product title" required>
                </div>

                <div class="form-group">
                    <label for="productDescription">Product Description *</label>
                    <textarea id="productDescription" name="productDescription" class="form-control" placeholder="Describe your product in detail..." required></textarea>
                </div>

                <div class="form-group">
                    <label for="productPrice">Price ($) *</label>
                    <input type="number" id="productPrice" name="productPrice" class="form-control" placeholder="0.00" step="0.01" min="0" required>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-plus"></i> List Product for Sale
                </button>
            </form>
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
</body>
</html>
SELLEOF

# 购物车页面（PHP版本）
cat > cart.php << 'CARTEOF'
<?php
require_once 'check_login.php';
$user = getUserInfo();
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
        .empty-cart { text-align: center; padding: 60px 20px; }
        .empty-cart i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .checkout-btn { background: #ff6b35; color: white; padding: 15px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 20px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="top-nav">
                <div class="logo">
                    <span class="logo-icon">🛒</span>
                    <a href="index.html" style="color: white; text-decoration: none;">ShopEasy</a>
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
        <h1 style="margin: 30px 0;">Shopping Cart</h1>
        
        <div class="cart-container">
            <div class="cart-items">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Your cart is empty</h2>
                    <p>Browse our products and add items to your cart</p>
                    <a href="index.html" style="display: inline-block; background: #ff6b35; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; margin-top: 20px;">
                        Continue Shopping
                    </a>
                </div>
            </div>

            <div class="cart-summary">
                <h3>Order Summary</h3>
                <div style="display: flex; justify-content: space-between; margin: 15px 0;">
                    <span>Subtotal:</span>
                    <span>$0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin: 15px 0; border-top: 2px solid #eee; padding-top: 15px; font-weight: bold; font-size: 18px;">
                    <span>Total:</span>
                    <span>$0.00</span>
                </div>
                <button class="checkout-btn" disabled>Proceed to Checkout</button>
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
</body>
</html>
CARTEOF

# 创建其他页面的PHP版本（简化版）
for page in profile my_products orders wishlist settings; do
    cat > ${page}.php << PAGEEOF
<?php
require_once 'check_login.php';
\$user = getUserInfo();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo ucfirst(\$page); ?> - ShopEasy</title>
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
        .main-content { background: white; padding: 40px; border-radius: 10px; margin: 30px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="top-nav">
                <div class="logo">
                    <span class="logo-icon">🛒</span>
                    <a href="index.html" style="color: white; text-decoration: none;">ShopEasy</a>
                </div>
                <div class="nav-links">
                    <span class="welcome-text">Welcome, <?php echo htmlspecialchars(\$user['name']); ?>!</span>
                    <a href="user_dashboard.php"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.php"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.php"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="main-content">
            <h1><?php echo ucfirst(\$page); ?> Page</h1>
            <p>This page is protected and requires login.</p>
            <p>Welcome, <?php echo htmlspecialchars(\$user['name']); ?> (<?php echo htmlspecialchars(\$user['email']); ?>)</p>
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
</body>
</html>
PAGEEOF
done

echo "Protected PHP pages created successfully!"
