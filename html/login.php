<?php
// login.php - 登录处理
require_once 'db_config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 获取表单数据
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    
    // 验证数据
    $errors = [];
    
    if (empty($email) || empty($password)) {
        $errors[] = "Email and password are required";
    }
    
    // 如果没有错误，验证用户
    if (empty($errors)) {
        try {
            $stmt = $pdo->prepare("SELECT id, first_name, last_name, email, password FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($user && password_verify($password, $user['password'])) {
                // 登录成功
                session_start();
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['user_name'] = $user['first_name'] . ' ' . $user['last_name'];
                $_SESSION['user_email'] = $user['email'];
                
                $response = [
                    'success' => true,
                    'message' => 'Login successful!',
                    'user' => [
                        'name' => $user['first_name'] . ' ' . $user['last_name'],
                        'email' => $user['email']
                    ]
                ];
            } else {
                $response = [
                    'success' => false,
                    'message' => 'Invalid email or password'
                ];
            }
        } catch(PDOException $e) {
            error_log("Database error in login: " . $e->getMessage());
            $response = [
                'success' => false,
                'message' => 'Database error: ' . $e->getMessage()
            ];
        }
    } else {
        $response = [
            'success' => false,
            'message' => implode('<br>', $errors)
        ];
    }
    
    echo json_encode($response);
    exit;
}
?>
