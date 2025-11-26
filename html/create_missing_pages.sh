#!/bin/bash

echo "Creating all missing pages..."

# 1. 个人资料编辑页面
cat > profile.html << 'PROFILEEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #ff6b35; color: white; }
        .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .profile-header { display: flex; align-items: center; gap: 20px; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        .avatar { width: 80px; height: 80px; background: #f8f9fa; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; color: #999; }
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        .btn-primary { background: #ff6b35; color: white; padding: 12px 25px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn-primary:hover { background: #e55a2b; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.html" class="active"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.html"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.html"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.html"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.html"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.html"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.html"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="profile-header">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div>
                        <h1>Edit Profile</h1>
                        <p>Update your personal information</p>
                    </div>
                </div>

                <form id="profileForm">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px;">
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" id="firstName" name="firstName" class="form-control" value="John" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" id="lastName" name="lastName" class="form-control" value="Doe" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-control" value="john.doe@example.com" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" placeholder="+1 (555) 123-4567">
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" class="form-control" placeholder="Enter your address" rows="3"></textarea>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin-bottom: 25px;">
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" class="form-control" placeholder="City">
                        </div>
                        <div class="form-group">
                            <label for="state">State</label>
                            <input type="text" id="state" name="state" class="form-control" placeholder="State">
                        </div>
                        <div class="form-group">
                            <label for="zipCode">ZIP Code</label>
                            <input type="text" id="zipCode" name="zipCode" class="form-control" placeholder="ZIP Code">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bio">Bio</label>
                        <textarea id="bio" name="bio" class="form-control" placeholder="Tell us about yourself..." rows="4"></textarea>
                    </div>

                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> Update Profile
                    </button>
                </form>
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
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Profile updated successfully!');
        });
    </script>
</body>
</html>
PROFILEEOF

# 2. 我的商品管理页面
cat > my_products.html << 'MYPRODUCTSEOF'
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
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #ff6b35; color: white; }
        .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .page-header { display: flex; justify-content: between; align-items: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        .btn-primary { background: #ff6b35; color: white; padding: 12px 25px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; text-decoration: none; display: inline-block; }
        .btn-primary:hover { background: #e55a2b; }
        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .product-card { border: 1px solid #eee; border-radius: 10px; overflow: hidden; transition: all 0.3s; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .product-image { width: 100%; height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #999; }
        .product-info { padding: 20px; }
        .product-title { font-weight: 600; margin-bottom: 10px; font-size: 16px; }
        .product-price { color: #ff6b35; font-weight: bold; font-size: 18px; margin-bottom: 10px; }
        .product-meta { display: flex; justify-content: space-between; color: #666; font-size: 14px; margin-bottom: 15px; }
        .product-actions { display: flex; gap: 10px; }
        .btn-edit { background: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; flex: 1; }
        .btn-delete { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; flex: 1; }
        .empty-state { text-align: center; padding: 60px 20px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } .products-grid { grid-template-columns: 1fr; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.html" class="active"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.html"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.html"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.html"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.html"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.html"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="page-header">
                    <h1>My Products</h1>
                    <a href="sell_product.html" class="btn-primary">
                        <i class="fas fa-plus"></i> Add New Product
                    </a>
                </div>

                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h2>No Products Yet</h2>
                    <p>Start selling by listing your first product</p>
                    <a href="sell_product.html" class="btn-primary" style="margin-top: 20px;">
                        <i class="fas fa-plus"></i> List Your First Product
                    </a>
                </div>

                <!-- Example product cards (commented out) -->
                <!--
                <div class="products-grid">
                    <div class="product-card">
                        <div class="product-image">Product Image</div>
                        <div class="product-info">
                            <div class="product-title">Sample Product 1</div>
                            <div class="product-price">$99.99</div>
                            <div class="product-meta">
                                <span>5 in stock</span>
                                <span>Active</span>
                            </div>
                            <div class="product-actions">
                                <button class="btn-edit">Edit</button>
                                <button class="btn-delete">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
                -->
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
MYPRODUCTSEOF

# 3. 订单管理页面
cat > orders.html << 'ORDERSEOF'
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
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #ff6b35; color: white; }
        .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .order-card { border: 1px solid #eee; border-radius: 10px; padding: 25px; margin-bottom: 20px; }
        .order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .order-id { font-weight: 600; color: #333; }
        .order-date { color: #666; }
        .order-status { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #d4edda; color: #155724; }
        .status-delivered { background: #d4edda; color: #155724; }
        .order-items { margin-bottom: 15px; }
        .order-item { display: flex; gap: 15px; padding: 10px 0; }
        .item-image { width: 60px; height: 60px; background: #f8f9fa; border-radius: 5px; display: flex; align-items: center; justify-content: center; color: #999; }
        .item-details { flex: 1; }
        .item-title { font-weight: 500; margin-bottom: 5px; }
        .item-price { color: #666; }
        .order-footer { display: flex; justify-content: space-between; align-items: center; }
        .order-total { font-weight: 600; font-size: 18px; color: #ff6b35; }
        .btn-track { background: #ff6b35; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; }
        .empty-state { text-align: center; padding: 60px 20px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } .order-header { flex-direction: column; align-items: flex-start; gap: 10px; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.html"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.html"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.html" class="active"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.html"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.html"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.html"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <h1 style="margin-bottom: 30px;">My Orders</h1>

                <div class="empty-state">
                    <i class="fas fa-shopping-bag"></i>
                    <h2>No Orders Yet</h2>
                    <p>Your order history will appear here</p>
                    <a href="index.html" class="btn-track" style="margin-top: 20px; display: inline-block; text-decoration: none;">
                        Start Shopping
                    </a>
                </div>

                <!-- Example order (commented out) -->
                <!--
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <div class="order-id">Order #12345</div>
                            <div class="order-date">Placed on November 25, 2023</div>
                        </div>
                        <div class="order-status status-pending">Pending</div>
                    </div>
                    <div class="order-items">
                        <div class="order-item">
                            <div class="item-image">IMG</div>
                            <div class="item-details">
                                <div class="item-title">Sample Product</div>
                                <div class="item-price">$99.99 x 1</div>
                            </div>
                        </div>
                    </div>
                    <div class="order-footer">
                        <div class="order-total">Total: $99.99</div>
                        <button class="btn-track">Track Order</button>
                    </div>
                </div>
                -->
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
ORDERSEOF

# 4. 愿望清单页面
cat > wishlist.html << 'WISHLISTEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #ff6b35; color: white; }
        .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .wishlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; }
        .wishlist-item { border: 1px solid #eee; border-radius: 10px; overflow: hidden; transition: all 0.3s; position: relative; }
        .wishlist-item:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .item-image { width: 100%; height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #999; }
        .item-info { padding: 20px; }
        .item-title { font-weight: 600; margin-bottom: 10px; font-size: 16px; }
        .item-price { color: #ff6b35; font-weight: bold; font-size: 18px; margin-bottom: 15px; }
        .item-actions { display: flex; gap: 10px; }
        .btn-cart { background: #ff6b35; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; flex: 2; }
        .btn-remove { background: #dc3545; color: white; padding: 10px; border: none; border-radius: 5px; cursor: pointer; flex: 1; }
        .remove-wishlist { position: absolute; top: 10px; right: 10px; background: white; border: none; border-radius: 50%; width: 30px; height: 30px; cursor: pointer; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .empty-state { text-align: center; padding: 60px 20px; color: #666; }
        .empty-state i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } .wishlist-grid { grid-template-columns: 1fr; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.html"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.html"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.html"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.html"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.html" class="active"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.html"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <h1 style="margin-bottom: 30px;">My Wishlist</h1>

                <div class="empty-state">
                    <i class="fas fa-heart"></i>
                    <h2>Your Wishlist is Empty</h2>
                    <p>Save items you love for later</p>
                    <a href="index.html" class="btn-cart" style="margin-top: 20px; display: inline-block; text-decoration: none;">
                        Browse Products
                    </a>
                </div>

                <!-- Example wishlist items (commented out) -->
                <!--
                <div class="wishlist-grid">
                    <div class="wishlist-item">
                        <button class="remove-wishlist">
                            <i class="fas fa-times"></i>
                        </button>
                        <div class="item-image">Product Image</div>
                        <div class="item-info">
                            <div class="item-title">Sample Product 1</div>
                            <div class="item-price">$99.99</div>
                            <div class="item-actions">
                                <button class="btn-cart">Add to Cart</button>
                                <button class="btn-remove">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                -->
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
WISHLISTEOF

# 5. 设置页面
cat > settings.html << 'SETTINGSEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .dashboard { display: flex; margin: 30px 0; gap: 30px; }
        .sidebar { width: 250px; background: white; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .sidebar-menu { list-style: none; }
        .sidebar-menu li { margin-bottom: 10px; }
        .sidebar-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 15px; color: #333; text-decoration: none; border-radius: 5px; transition: all 0.3s; }
        .sidebar-menu a:hover { background: #ff6b35; color: white; }
        .sidebar-menu a.active { background: #ff6b35; color: white; }
        .main-content { flex: 1; background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .settings-section { margin-bottom: 40px; padding-bottom: 30px; border-bottom: 1px solid #eee; }
        .settings-section:last-child { border-bottom: none; margin-bottom: 0; }
        .section-title { font-size: 20px; font-weight: 600; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        .btn-primary { background: #ff6b35; color: white; padding: 12px 25px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn-primary:hover { background: #e55a2b; }
        .btn-danger { background: #dc3545; color: white; padding: 12px 25px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn-danger:hover { background: #c82333; }
        .switch { position: relative; display: inline-block; width: 60px; height: 34px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 34px; }
        .slider:before { position: absolute; content: ""; height: 26px; width: 26px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: #ff6b35; }
        input:checked + .slider:before { transform: translateX(26px); }
        .toggle-group { display: flex; justify-content: space-between; align-items: center; padding: 15px 0; border-bottom: 1px solid #eee; }
        .toggle-group:last-child { border-bottom: none; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .dashboard { flex-direction: column; } .sidebar { width: 100%; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="dashboard">
            <div class="sidebar">
                <ul class="sidebar-menu">
                    <li><a href="user_dashboard.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
                    <li><a href="my_products.html"><i class="fas fa-box"></i> My Products</a></li>
                    <li><a href="sell_product.html"><i class="fas fa-plus-circle"></i> Sell Product</a></li>
                    <li><a href="orders.html"><i class="fas fa-shopping-bag"></i> My Orders</a></li>
                    <li><a href="cart.html"><i class="fas fa-shopping-cart"></i> Shopping Cart</a></li>
                    <li><a href="wishlist.html"><i class="fas fa-heart"></i> Wishlist</a></li>
                    <li><a href="settings.html" class="active"><i class="fas fa-cog"></i> Settings</a></li>
                </ul>
            </div>

            <div class="main-content">
                <h1 style="margin-bottom: 30px;">Account Settings</h1>

                <div class="settings-section">
                    <h2 class="section-title">Notification Settings</h2>
                    <div class="toggle-group">
                        <div>
                            <strong>Email Notifications</strong>
                            <p>Receive updates about your orders and promotions</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <div>
                            <strong>SMS Notifications</strong>
                            <p>Get order updates via text message</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <div>
                            <strong>Promotional Emails</strong>
                            <p>Receive special offers and discounts</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="settings-section">
                    <h2 class="section-title">Privacy Settings</h2>
                    <div class="toggle-group">
                        <div>
                            <strong>Public Profile</strong>
                            <p>Allow others to view your profile</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="toggle-group">
                        <div>
                            <strong>Show Email</strong>
                            <p>Display your email address on your public profile</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="settings-section">
                    <h2 class="section-title">Change Password</h2>
                    <form id="passwordForm">
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" class="form-control" placeholder="Enter current password">
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" class="form-control" placeholder="Enter new password">
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm new password">
                        </div>
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-key"></i> Update Password
                        </button>
                    </form>
                </div>

                <div class="settings-section">
                    <h2 class="section-title">Account Actions</h2>
                    <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                        <button class="btn-danger">
                            <i class="fas fa-file-export"></i> Export Data
                        </button>
                        <button class="btn-danger">
                            <i class="fas fa-user-slash"></i> Deactivate Account
                        </button>
                        <button class="btn-danger" style="background: #dc3545;">
                            <i class="fas fa-trash"></i> Delete Account
                        </button>
                    </div>
                </div>
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
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Password updated successfully!');
        });
    </script>
</body>
</html>
SETTINGSEOF

# 6. 商品详情页面
cat > product_detail.html << 'PRODUCTDETAILEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .product-detail { display: flex; gap: 40px; margin: 30px 0; }
        .product-gallery { flex: 1; }
        .main-image { width: 100%; height: 400px; background: #f8f9fa; border-radius: 10px; display: flex; align-items: center; justify-content: center; color: #999; margin-bottom: 15px; }
        .thumbnail-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
        .thumbnail { width: 100%; height: 80px; background: #f8f9fa; border-radius: 5px; display: flex; align-items: center; justify-content: center; color: #999; cursor: pointer; }
        .product-info { flex: 1; }
        .product-title { font-size: 28px; font-weight: 600; margin-bottom: 10px; }
        .product-price { font-size: 32px; color: #ff6b35; font-weight: bold; margin-bottom: 20px; }
        .product-meta { display: flex; gap: 20px; margin-bottom: 20px; color: #666; }
        .rating { color: #ffc107; }
        .product-description { margin-bottom: 25px; line-height: 1.8; }
        .quantity-selector { display: flex; align-items: center; gap: 15px; margin-bottom: 25px; }
        .quantity-btn { width: 40px; height: 40px; border: 1px solid #ddd; background: white; border-radius: 5px; cursor: pointer; font-size: 18px; }
        .quantity-input { width: 60px; height: 40px; border: 1px solid #ddd; border-radius: 5px; text-align: center; }
        .action-buttons { display: flex; gap: 15px; margin-bottom: 25px; }
        .btn-cart { background: #ff6b35; color: white; padding: 15px 30px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; flex: 2; }
        .btn-wishlist { background: white; color: #333; padding: 15px; border: 1px solid #ddd; border-radius: 5px; cursor: pointer; flex: 1; }
        .product-specs { background: white; padding: 30px; border-radius: 10px; margin-top: 40px; }
        .specs-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; }
        .spec-item { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #eee; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .product-detail { flex-direction: column; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="product-detail">
            <div class="product-gallery">
                <div class="main-image">
                    <i class="fas fa-camera" style="font-size: 48px;"></i>
                </div>
                <div class="thumbnail-grid">
                    <div class="thumbnail"><i class="fas fa-image"></i></div>
                    <div class="thumbnail"><i class="fas fa-image"></i></div>
                    <div class="thumbnail"><i class="fas fa-image"></i></div>
                    <div class="thumbnail"><i class="fas fa-image"></i></div>
                </div>
            </div>

            <div class="product-info">
                <h1 class="product-title">Premium Wireless Headphones</h1>
                <div class="product-price">$199.99</div>
                
                <div class="product-meta">
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span style="color: #666; margin-left: 5px;">(128 reviews)</span>
                    </div>
                    <div>In Stock: 25</div>
                </div>

                <div class="product-description">
                    <p>Experience premium sound quality with our latest wireless headphones. Featuring noise cancellation, 30-hour battery life, and comfortable over-ear design. Perfect for music lovers and professionals alike.</p>
                    <p>Key features include Bluetooth 5.0, quick charging, and built-in microphone for crystal-clear calls.</p>
                </div>

                <div class="quantity-selector">
                    <label>Quantity:</label>
                    <button class="quantity-btn">-</button>
                    <input type="text" class="quantity-input" value="1">
                    <button class="quantity-btn">+</button>
                </div>

                <div class="action-buttons">
                    <button class="btn-cart">
                        <i class="fas fa-shopping-cart"></i> Add to Cart
                    </button>
                    <button class="btn-wishlist">
                        <i class="fas fa-heart"></i> Wishlist
                    </button>
                </div>

                <div style="color: #666; font-size: 14px;">
                    <p><i class="fas fa-shipping-fast"></i> Free shipping on orders over $50</p>
                    <p><i class="fas fa-undo"></i> 30-day return policy</p>
                    <p><i class="fas fa-shield-alt"></i> 2-year warranty included</p>
                </div>
            </div>
        </div>

        <div class="product-specs">
            <h2 style="margin-bottom: 20px;">Product Specifications</h2>
            <div class="specs-grid">
                <div class="spec-item">
                    <span>Brand</span>
                    <span>AudioPro</span>
                </div>
                <div class="spec-item">
                    <span>Model</span>
                    <span>WH-2023</span>
                </div>
                <div class="spec-item">
                    <span>Connectivity</span>
                    <span>Bluetooth 5.0</span>
                </div>
                <div class="spec-item">
                    <span>Battery Life</span>
                    <span>30 hours</span>
                </div>
                <div class="spec-item">
                    <span>Noise Cancellation</span>
                    <span>Active</span>
                </div>
                <div class="spec-item">
                    <span>Weight</span>
                    <span>285g</span>
                </div>
                <div class="spec-item">
                    <span>Color</span>
                    <span>Matte Black</span>
                </div>
                <div class="spec-item">
                    <span>Warranty</span>
                    <span>2 years</span>
                </div>
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
PRODUCTDETAILEOF

# 7. 结算页面
cat > checkout.html << 'CHECKOUTEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .checkout-container { display: flex; gap: 40px; margin: 30px 0; }
        .checkout-form { flex: 2; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .order-summary { flex: 1; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); height: fit-content; }
        .form-section { margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        .section-title { font-size: 20px; font-weight: 600; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .order-item { display: flex; gap: 15px; padding: 15px 0; border-bottom: 1px solid #eee; }
        .item-image { width: 60px; height: 60px; background: #f8f9fa; border-radius: 5px; display: flex; align-items: center; justify-content: center; color: #999; }
        .item-details { flex: 1; }
        .item-title { font-weight: 500; margin-bottom: 5px; }
        .item-price { color: #666; }
        .summary-line { display: flex; justify-content: space-between; margin: 10px 0; }
        .total { border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px; font-weight: bold; font-size: 18px; }
        .btn-checkout { background: #ff6b35; color: white; padding: 15px; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 20px; }
        .btn-checkout:hover { background: #e55a2b; }
        .payment-methods { display: flex; gap: 15px; margin-bottom: 20px; }
        .payment-method { flex: 1; text-align: center; padding: 15px; border: 2px solid #ddd; border-radius: 5px; cursor: pointer; transition: all 0.3s; }
        .payment-method.active { border-color: #ff6b35; background: #fff5f2; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: 50px; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .checkout-container { flex-direction: column; } .form-row { grid-template-columns: 1fr; } }
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
                    <a href="user_dashboard.html"><i class="fas fa-user"></i> Dashboard</a>
                    <a href="sell_product.html"><i class="fas fa-plus"></i> Sell Product</a>
                    <a href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a>
                    <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 style="margin: 30px 0;">Checkout</h1>
        
        <div class="checkout-container">
            <div class="checkout-form">
                <div class="form-section">
                    <h2 class="section-title">Shipping Information</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" id="firstName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" id="lastName" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address *</label>
                        <input type="text" id="address" class="form-control" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">City *</label>
                            <input type="text" id="city" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="state">State *</label>
                            <input type="text" id="state" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="zipCode">ZIP Code *</label>
                            <input type="text" id="zipCode" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number *</label>
                        <input type="tel" id="phone" class="form-control" required>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">Payment Method</h2>
                    <div class="payment-methods">
                        <div class="payment-method active">
                            <i class="fab fa-cc-visa" style="font-size: 32px; color: #1a1f71;"></i>
                            <p>Credit Card</p>
                        </div>
                        <div class="payment-method">
                            <i class="fab fa-paypal" style="font-size: 32px; color: #003087;"></i>
                            <p>PayPal</p>
                        </div>
                        <div class="payment-method">
                            <i class="fas fa-university" style="font-size: 32px; color: #666;"></i>
                            <p>Bank Transfer</p>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardNumber">Card Number *</label>
                            <input type="text" id="cardNumber" class="form-control" placeholder="1234 5678 9012 3456" required>
                        </div>
                        <div class="form-group">
                            <label for="cardName">Name on Card *</label>
                            <input type="text" id="cardName" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="expiryDate">Expiry Date *</label>
                            <input type="text" id="expiryDate" class="form-control" placeholder="MM/YY" required>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV *</label>
                            <input type="text" id="cvv" class="form-control" placeholder="123" required>
                        </div>
                    </div>
                </div>
            </div>

            <div class="order-summary">
                <h2 class="section-title">Order Summary</h2>
                
                <div class="order-item">
                    <div class="item-image">IMG</div>
                    <div class="item-details">
                        <div class="item-title">Wireless Headphones</div>
                        <div class="item-price">$199.99 x 1</div>
                    </div>
                </div>

                <div class="order-item">
                    <div class="item-image">IMG</div>
                    <div class="item-details">
                        <div class="item-title">Phone Case</div>
                        <div class="item-price">$24.99 x 2</div>
                    </div>
                </div>

                <div class="summary-line">
                    <span>Subtotal:</span>
                    <span>$249.97</span>
                </div>
                <div class="summary-line">
                    <span>Shipping:</span>
                    <span>$9.99</span>
                </div>
                <div class="summary-line">
                    <span>Tax:</span>
                    <span>$20.00</span>
                </div>
                <div class="summary-line total">
                    <span>Total:</span>
                    <span>$279.96</span>
                </div>

                <button class="btn-checkout">
                    <i class="fas fa-lock"></i> Place Order
                </button>

                <p style="text-align: center; margin-top: 15px; color: #666; font-size: 14px;">
                    <i class="fas fa-lock"></i> Your payment information is secure
                </p>
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
        // Payment method selection
        document.querySelectorAll('.payment-method').forEach(method => {
            method.addEventListener('click', function() {
                document.querySelectorAll('.payment-method').forEach(m => m.classList.remove('active'));
                this.classList.add('active');
            });
        });

        document.querySelector('.btn-checkout').addEventListener('click', function() {
            alert('Order placed successfully! Thank you for your purchase.');
            window.location.href = 'orders.html';
        });
    </script>
</body>
</html>
CHECKOUTEOF

echo "All missing pages created successfully!"
echo ""
echo "New pages created:"
echo "1. profile.html - Edit Profile"
echo "2. my_products.html - My Products Management" 
echo "3. orders.html - Order Management"
echo "4. wishlist.html - Wishlist"
echo "5. settings.html - Account Settings"
echo "6. product_detail.html - Product Details"
echo "7. checkout.html - Checkout Page"
echo ""
echo "Total pages now: 15 HTML pages"
