<?php
session_start();
echo "<h1>Session Test</h1>";
echo "<pre>";
echo "Session ID: " . session_id() . "\n";
echo "Session Data: ";
print_r($_SESSION);
echo "</pre>";

// 测试数据库连接
require_once 'db_config.php';
try {
    $stmt = $pdo->query("SELECT 1");
    echo "<p style='color: green;'>Database connection: SUCCESS</p>";
} catch(PDOException $e) {
    echo "<p style='color: red;'>Database connection: FAILED - " . $e->getMessage() . "</p>";
}
?>
