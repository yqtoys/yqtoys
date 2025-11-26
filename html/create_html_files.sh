#!/bin/bash

# 主页 index.html
cat > index.html << 'INDEXEOF'
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
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
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
                    ShopEasy
                </div>
                <div class="nav-links">
                    <a href="login.html"><i class="fas fa-user"></i> Login</a>
                    <a href="register.html"><i class="fas fa-user-plus"></i> Register</a>
                    <a href="#"><i class="fas fa-store"></i> Sell on ShopEasy</a>
                    <a href="#"><i class="fas fa-shopping-cart"></i> Cart</a>
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
        <div class="products" id="products-container"></div>
        
        <h2 class="section-title">New Arrivals</h2>
        <div class="products" id="new-products-container"></div>
    </div>
    
    <div class="footer">
        <div class="container">
            <div class="footer-links">
                <a href="#">About Us</a>
                <a href="#">Contact</a>
                <a href="#">Terms of Service</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Sell on ShopEasy</a>
                <a href="#">Help Center</a>
            </div>
            <p>© 2023 ShopEasy Inc. | Your Trusted Online Shopping Platform</p>
        </div>
    </div>

    <script>
        const sampleProducts = [
            { id: 1, title: "Smartphone 128GB Large Memory HD Camera Long Battery", price: 1999.00, seller: "Official Store", isNew: false },
            { id: 2, title: "Laptop Computer Lightweight Portable High Performance", price: 5999.00, seller: "Tech Store", isNew: false },
            { id: 3, title: "Wireless Bluetooth Headphones Noise Cancelling", price: 299.00, seller: "Audio Experts", isNew: true },
            { id: 4, title: "Running Shoes Breathable Comfortable Athletic", price: 399.00, seller: "Sports Outlet", isNew: false },
            { id: 5, title: "Home Air Purifier Remove PM2.5 Smart Control", price: 899.00, seller: "Home Essentials", isNew: true },
            { id: 6, title: "Skincare Set Moisturizing Anti-aging Complete Care", price: 599.00, seller: "Beauty Official", isNew: false },
            { id: 7, title: "Smart Watch Fitness Tracker Heart Rate Monitor", price: 1299.00, seller: "Gadget Store", isNew: true },
            { id: 8, title: "Camera Backpack Multi-functional Waterproof Large Capacity", price: 259.00, seller: "Outdoor Gear", isNew: true }
        ];
        
        function renderProducts(products, containerId, filterNew = false) {
            const container = document.getElementById(containerId);
            container.innerHTML = '';
            const filteredProducts = filterNew ? products.filter(product => product.isNew) : products.filter(product => !product.isNew);
            filteredProducts.forEach(product => {
                const productCard = document.createElement('div');
                productCard.className = 'product-card';
                productCard.innerHTML = `
                    <div class="product-img"></div>
                    <div class="product-info">
                        <div class="product-title">${product.title}</div>
                        <div class="product-price">$${product.price.toFixed(2)}</div>
                        <div class="product-seller">Sold by: ${product.seller}</div>
                        <div class="product-actions">
                            <button class="btn-cart"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                            <button class="btn-buy">Buy Now</button>
                        </div>
                    </div>
                `;
                container.appendChild(productCard);
            });
        }
        
        document.addEventListener('DOMContentLoaded', () => {
            renderProducts(sampleProducts, 'products-container');
            renderProducts(sampleProducts, 'new-products-container', true);
        });
    </script>
</body>
</html>
INDEXEOF

# 登录页面 login.html
cat > login.html << 'LOGINEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; display: flex; flex-direction: column; min-height: 100vh; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; box-shadow: 0 2px 10px rgba(255, 107, 53, 0.3); }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .login-container { display: flex; justify-content: center; align-items: center; flex-grow: 1; padding: 40px 0; }
        .login-box { background: white; border-radius: 10px; box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1); width: 400px; padding: 40px; }
        .login-header { text-align: center; margin-bottom: 30px; }
        .login-header h2 { color: #333; margin-bottom: 10px; }
        .login-header p { color: #666; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        .btn-login { width: 100%; padding: 12px; background: #ff6b35; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn-login:hover { background: #e55a2b; }
        .login-options { display: flex; justify-content: space-between; margin: 15px 0 25px; font-size: 14px; }
        .remember-me { display: flex; align-items: center; }
        .remember-me input { margin-right: 5px; }
        .forgot-password { color: #ff6b35; text-decoration: none; }
        .forgot-password:hover { text-decoration: underline; }
        .divider { text-align: center; margin: 25px 0; position: relative; color: #999; }
        .divider::before { content: ""; position: absolute; top: 50%; left: 0; right: 0; height: 1px; background: #eee; z-index: 1; }
        .divider span { background: white; padding: 0 15px; position: relative; z-index: 2; }
        .social-login { display: flex; gap: 15px; }
        .btn-social { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px; background: white; display: flex; align-items: center; justify-content: center; gap: 8px; cursor: pointer; transition: background 0.3s; }
        .btn-social:hover { background: #f5f5f5; }
        .btn-google { color: #db4437; }
        .btn-facebook { color: #4267B2; }
        .signup-link { text-align: center; margin-top: 25px; color: #666; }
        .signup-link a { color: #ff6b35; text-decoration: none; font-weight: 500; }
        .signup-link a:hover { text-decoration: underline; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: auto; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .login-box { width: 90%; padding: 30px 25px; } }
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
                    <a href="index.html"><i class="fas fa-home"></i> Home</a>
                    <a href="register.html"><i class="fas fa-user-plus"></i> Register</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your account to continue shopping</p>
            </div>
            
            <form id="loginForm">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" class="form-control" placeholder="Enter your password" required>
                </div>
                
                <div class="login-options">
                    <div class="remember-me">
                        <input type="checkbox" id="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>
                
                <button type="submit" class="btn-login">Sign In</button>
            </form>
            
            <div class="divider">
                <span>Or continue with</span>
            </div>
            
            <div class="social-login">
                <button class="btn-social btn-google">
                    <i class="fab fa-google"></i>
                    <span>Google</span>
                </button>
                <button class="btn-social btn-facebook">
                    <i class="fab fa-facebook-f"></i>
                    <span>Facebook</span>
                </button>
            </div>
            
            <div class="signup-link">
                Don't have an account? <a href="register.html">Sign up here</a>
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
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const submitBtn = this.querySelector('.btn-login');
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Signing in...';
            submitBtn.disabled = true;
            
            fetch('login.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    window.location.href = 'index.html';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Login failed, please try again later');
            })
            .finally(() => {
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            });
        });
    </script>
</body>
</html>
LOGINEOF

# 注册页面 register.html
cat > register.html << 'REGISTEREOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ShopEasy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; line-height: 1.6; display: flex; flex-direction: column; min-height: 100vh; }
        .container { width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%); color: white; padding: 12px 0; box-shadow: 0 2px 10px rgba(255, 107, 53, 0.3); }
        .top-nav { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 26px; font-weight: bold; display: flex; align-items: center; }
        .logo-icon { margin-right: 10px; font-size: 28px; }
        .nav-links { display: flex; gap: 20px; }
        .nav-links a { color: white; padding: 8px 15px; border-radius: 4px; transition: background-color 0.3s; text-decoration: none; }
        .nav-links a:hover { background-color: rgba(255, 255, 255, 0.2); }
        .register-container { display: flex; justify-content: center; align-items: center; flex-grow: 1; padding: 40px 0; }
        .register-box { background: white; border-radius: 10px; box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1); width: 450px; padding: 40px; }
        .register-header { text-align: center; margin-bottom: 30px; }
        .register-header h2 { color: #333; margin-bottom: 10px; }
        .register-header p { color: #666; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #555; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 5px; font-size: 16px; transition: border 0.3s; }
        .form-control:focus { border-color: #ff6b35; outline: none; box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2); }
        .name-fields { display: flex; gap: 15px; }
        .name-fields .form-group { flex: 1; }
        .btn-register { width: 100%; padding: 12px; background: #ff6b35; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        .btn-register:hover { background: #e55a2b; }
        .terms { margin: 20px 0; font-size: 14px; color: #666; }
        .terms input { margin-right: 5px; }
        .terms a { color: #ff6b35; text-decoration: none; }
        .terms a:hover { text-decoration: underline; }
        .divider { text-align: center; margin: 25px 0; position: relative; color: #999; }
        .divider::before { content: ""; position: absolute; top: 50%; left: 0; right: 0; height: 1px; background: #eee; z-index: 1; }
        .divider span { background: white; padding: 0 15px; position: relative; z-index: 2; }
        .social-register { display: flex; gap: 15px; }
        .btn-social { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px; background: white; display: flex; align-items: center; justify-content: center; gap: 8px; cursor: pointer; transition: background 0.3s; }
        .btn-social:hover { background: #f5f5f5; }
        .btn-google { color: #db4437; }
        .btn-facebook { color: #4267B2; }
        .login-link { text-align: center; margin-top: 25px; color: #666; }
        .login-link a { color: #ff6b35; text-decoration: none; font-weight: 500; }
        .login-link a:hover { text-decoration: underline; }
        .password-strength { margin-top: 5px; font-size: 12px; display: none; }
        .strength-weak { color: #e74c3c; }
        .strength-medium { color: #f39c12; }
        .strength-strong { color: #2ecc71; }
        .footer { background-color: white; padding: 30px 0; text-align: center; color: #999; border-top: 1px solid #eee; margin-top: auto; }
        .footer-links { display: flex; justify-content: center; margin-bottom: 15px; flex-wrap: wrap; }
        .footer-links a { margin: 0 15px; color: #666; transition: color 0.3s; text-decoration: none; }
        .footer-links a:hover { color: #ff6b35; }
        @media (max-width: 768px) { .container { width: 95%; } .register-box { width: 90%; padding: 30px 25px; } .name-fields { flex-direction: column; gap: 0; } }
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
                    <a href="index.html"><i class="fas fa-home"></i> Home</a>
                    <a href="login.html"><i class="fas fa-user"></i> Login</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="register-container">
        <div class="register-box">
            <div class="register-header">
                <h2>Create Your Account</h2>
                <p>Join ShopEasy to start shopping today</p>
            </div>
            
            <form id="registerForm">
                <div class="name-fields">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" class="form-control" placeholder="First name" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" class="form-control" placeholder="Last name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" class="form-control" placeholder="Create a password" required>
                    <div id="passwordStrength" class="password-strength"></div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm your password" required>
                    <div id="passwordMatch" class="password-strength"></div>
                </div>
                
                <div class="terms">
                    <input type="checkbox" id="agreeTerms" required>
                    <label for="agreeTerms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                </div>
                
                <button type="submit" class="btn-register">Create Account</button>
            </form>
            
            <div class="divider">
                <span>Or sign up with</span>
            </div>
            
            <div class="social-register">
                <button class="btn-social btn-google">
                    <i class="fab fa-google"></i>
                    <span>Google</span>
                </button>
                <button class="btn-social btn-facebook">
                    <i class="fab fa-facebook-f"></i>
                    <span>Facebook</span>
                </button>
            </div>
            
            <div class="login-link">
                Already have an account? <a href="login.html">Sign in here</a>
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
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthIndicator = document.getElementById('passwordStrength');
            
            if (password.length === 0) {
                strengthIndicator.style.display = 'none';
                return;
            }
            
            strengthIndicator.style.display = 'block';
            let strength = 0;
            if (password.length >= 8) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            if (strength < 2) {
                strengthIndicator.textContent = 'Weak password';
                strengthIndicator.className = 'password-strength strength-weak';
            } else if (strength < 4) {
                strengthIndicator.textContent = 'Medium strength password';
                strengthIndicator.className = 'password-strength strength-medium';
            } else {
                strengthIndicator.textContent = 'Strong password';
                strengthIndicator.className = 'password-strength strength-strong';
            }
        });
        
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const matchIndicator = document.getElementById('passwordMatch');
            
            if (confirmPassword.length === 0) {
                matchIndicator.style.display = 'none';
                return;
            }
            
            matchIndicator.style.display = 'block';
            
            if (password === confirmPassword) {
                matchIndicator.textContent = 'Passwords match';
                matchIndicator.className = 'password-strength strength-strong';
            } else {
                matchIndicator.textContent = 'Passwords do not match';
                matchIndicator.className = 'password-strength strength-weak';
            }
        });
        
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const submitBtn = this.querySelector('.btn-register');
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Registering...';
            submitBtn.disabled = true;
            
            fetch('register.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    window.location.href = 'login.html';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Registration failed, please try again later');
            })
            .finally(() => {
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            });
        });
    </script>
</body>
</html>
REGISTEREOF

echo "All HTML files created successfully!"
