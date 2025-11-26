<?php
require_once 'db_config.php';

try {
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
    $result = $stmt->fetch();
    echo "SUCCESS: Database connected! Users count: " . $result['count'];
    
    // 测试插入
    $testEmail = "test_" . time() . "@test.com";
    $stmt = $pdo->prepare("INSERT INTO users (first_name, last_name, email, password) VALUES (?, ?, ?, ?)");
    $stmt->execute(["Test", "User", $testEmail, password_hash("test123", PASSWORD_DEFAULT)]);
    echo "<br>SUCCESS: Test user inserted!";
    
} catch(PDOException $e) {
    echo "ERROR: " . $e->getMessage();
}
?>
