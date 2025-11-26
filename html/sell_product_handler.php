<?php
// sell_product_handler.php - 处理商品发布表单
require_once 'db_config.php';
require_once 'session.php';

// 检查用户是否登录
if (!isLoggedIn()) {
    header('Location: login.html');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_SESSION['user_id'];
    $title = trim($_POST['productTitle']);
    $description = trim($_POST['productDescription']);
    $price = floatval($_POST['productPrice']);
    
    // 验证数据
    $errors = [];
    
    if (empty($title) || empty($description)) {
        $errors[] = "All required fields must be filled";
    }
    
    if ($price <= 0) {
        $errors[] = "Price must be greater than 0";
    }
    
    if (empty($errors)) {
        try {
            // 插入商品到数据库
            $stmt = $pdo->prepare("INSERT INTO products (title, description, price, seller_id, status) VALUES (?, ?, ?, ?, 'active')");
            
            if ($stmt->execute([$title, $description, $price, $user_id])) {
                $product_id = $pdo->lastInsertId();
                
                // 成功消息
                echo "<!DOCTYPE html>
                <html>
                <head>
                    <title>Product Listed - ShopEasy</title>
                    <style>
                        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                        .success { color: green; font-size: 24px; margin-bottom: 20px; }
                        .btn { background: #ff6b35; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px; }
                    </style>
                </head>
                <body>
                    <div class='success'>
                        <i class='fas fa-check-circle'></i> Product listed successfully!
                    </div>
                    <p>Your product \"$title\" has been listed for sale.</p>
                    <div>
                        <a href='sell_product.php' class='btn'>List Another Product</a>
                        <a href='my_products.php' class='btn'>View My Products</a>
                        <a href='user_dashboard.php' class='btn'>Dashboard</a>
                    </div>
                </body>
                </html>";
            } else {
                throw new Exception("Failed to insert product");
            }
        } catch(PDOException $e) {
            echo "<!DOCTYPE html>
            <html>
            <head>
                <title>Error - ShopEasy</title>
                <style>
                    body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                    .error { color: red; font-size: 24px; margin-bottom: 20px; }
                    .btn { background: #ff6b35; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px; }
                </style>
            </head>
            <body>
                <div class='error'>
                    <i class='fas fa-exclamation-circle'></i> Error listing product
                </div>
                <p>There was an error listing your product. Please try again.</p>
                <p>Error: " . $e->getMessage() . "</p>
                <a href='sell_product.php' class='btn'>Go Back</a>
            </body>
            </html>";
        }
    } else {
        // 显示错误信息
        echo "<!DOCTYPE html>
        <html>
        <head>
            <title>Error - ShopEasy</title>
            <style>
                body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                .error { color: red; font-size: 24px; margin-bottom: 20px; }
                .btn { background: #ff6b35; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px; }
            </style>
        </head>
        <body>
            <div class='error'>
                <i class='fas fa-exclamation-circle'></i> Please correct the following errors:
            </div>
            <ul style='text-align: left; display: inline-block;'>";
        foreach ($errors as $error) {
            echo "<li>$error</li>";
        }
        echo "</ul>
            <br>
            <a href='sell_product.php' class='btn'>Go Back</a>
        </body>
        </html>";
    }
} else {
    // 如果不是POST请求，重定向到发布页面
    header('Location: sell_product.php');
    exit;
}
?>
