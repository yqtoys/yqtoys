<?php
// db_config.php - 数据库配置文件
$host = 'localhost';
$dbname = 'shopeasy';
$username = 'shopeasy_user';
$password = 'ShopEasy123!';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}
?>
