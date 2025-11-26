<?php
// 启用错误显示用于调试
error_reporting(E_ALL);
ini_set('display_errors', 1);

// 包含必要的文件
require_once 'db_config.php';
require_once 'session.php';

// 检查登录
if (!isLoggedIn()) {
    header('Location: login.html');
    exit;
}

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
        .image-upload { border: 2px dashed #ddd; padding: 30px; text-align: center; border-radius: 5px; margin-bottom: 20px; }
        .image-upload:hover { border-color: #ff6b35; }
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

                <div class="form-group">
                    <label for="productCategory">Category *</label>
                    <select id="productCategory" name="productCategory" class="form-control" required>
                        <option value="">Select Category</option>
                        <option value="electronics">Electronics</option>
                        <option value="clothing">Clothing & Fashion</option>
                        <option value="home">Home & Garden</option>
                        <option value="sports">Sports & Outdoors</option>
                        <option value="books">Books & Media</option>
                        <option value="toys">Toys & Games</option>
                        <option value="beauty">Beauty & Health</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="productQuantity">Quantity Available *</label>
                    <input type="number" id="productQuantity" name="productQuantity" class="form-control" placeholder="1" min="1" required>
                </div>

                <div class="form-group">
                    <label>Product Images</label>
                    <div class="image-upload">
                        <i class="fas fa-cloud-upload-alt" style="font-size: 48px; color: #ddd; margin-bottom: 15px;"></i>
                        <p>Click to upload or drag and drop</p>
                        <p style="font-size: 12px; color: #999;">PNG, JPG, GIF up to 10MB</p>
                        <input type="file" id="productImages" name="productImages" multiple accept="image/*" style="display: none;">
                        <button type="button" onclick="document.getElementById('productImages').click()" style="background: #f8f9fa; border: 1px solid #ddd; padding: 8px 15px; border-radius: 5px; margin-top: 10px; cursor: pointer;">Choose Files</button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="shippingInfo">Shipping Information</label>
                    <textarea id="shippingInfo" name="shippingInfo" class="form-control" placeholder="Shipping details, delivery time, etc."></textarea>
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

    <script>
        document.getElementById('sellForm').addEventListener('submit', function(e) {
            // 表单验证
            const title = document.getElementById('productTitle').value;
            const price = document.getElementById('productPrice').value;
            
            if (!title.trim()) {
                alert('Please enter a product title');
                e.preventDefault();
                return;
            }
            
            if (price <= 0) {
                alert('Please enter a valid price');
                e.preventDefault();
                return;
            }
            
            // 表单会正常提交到sell_product_handler.php
        });
    </script>
</body>
</html>
