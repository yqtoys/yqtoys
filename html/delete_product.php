<?php
// delete_product.php - 处理商品删除
require_once 'db_config.php';
require_once 'session.php';

header('Content-Type: application/json');

// 检查用户是否登录
if (!isLoggedIn()) {
    echo json_encode(['success' => false, 'message' => 'Please login to manage products']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['id'])) {
    $product_id = intval($_GET['id']);
    $user_id = $_SESSION['user_id'];
    
    try {
        // 检查商品是否属于当前用户
        $stmt = $pdo->prepare("SELECT id FROM products WHERE id = ? AND seller_id = ?");
        $stmt->execute([$product_id, $user_id]);
        $product = $stmt->fetch();
        
        if (!$product) {
            echo json_encode(['success' => false, 'message' => 'Product not found or access denied']);
            exit;
        }
        
        // 删除商品
        $stmt = $pdo->prepare("DELETE FROM products WHERE id = ?");
        if ($stmt->execute([$product_id])) {
            echo json_encode(['success' => true, 'message' => 'Product deleted successfully']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to delete product']);
        }
    } catch(PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request']);
}
?>
