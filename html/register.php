<?php
// register.php - 用户注册处理
require_once 'db_config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 获取表单数据
    $firstName = trim($_POST['firstName']);
    $lastName = trim($_POST['lastName']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirmPassword = $_POST['confirmPassword'];
    
    // 验证数据
    $errors = [];
    
    if (empty($firstName) || empty($lastName) || empty($email) || empty($password)) {
        $errors[] = "All fields are required";
    }
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "Invalid email format";
    }
    
    if ($password !== $confirmPassword) {
        $errors[] = "Passwords do not match";
    }
    
    if (strlen($password) < 6) {
        $errors[] = "Password must be at least 6 characters";
    }
    
    // 检查邮箱是否已存在
    try {
        $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->execute([$email]);
        if ($stmt->rowCount() > 0) {
            $errors[] = "Email already registered";
        }
    } catch(PDOException $e) {
        error_log("Database error in email check: " . $e->getMessage());
        $errors[] = "Database error in email check";
    }
    
    // 如果没有错误，保存用户数据
    if (empty($errors)) {
        try {
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            
            $stmt = $pdo->prepare("INSERT INTO users (first_name, last_name, email, password) VALUES (?, ?, ?, ?)");
            
            if ($stmt->execute([$firstName, $lastName, $email, $hashedPassword])) {
                $response = [
                    'success' => true,
                    'message' => 'Registration successful! Please login.'
                ];
                error_log("User registered successfully: " . $email);
            } else {
                $response = [
                    'success' => false,
                    'message' => 'Registration failed, please try again.'
                ];
                error_log("Registration failed for: " . $email);
            }
        } catch(PDOException $e) {
            error_log("Database error in registration: " . $e->getMessage());
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
} else {
    $response = [
        'success' => false,
        'message' => 'Invalid request method'
    ];
    echo json_encode($response);
    exit;
}
?>
