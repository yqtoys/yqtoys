#!/bin/bash

# db_config.php
cat > db_config.php << 'DBEOF'
<?php
\$host = 'localhost';
\$dbname = 'shopeasy';
\$username = 'shopeasy_user';
\$password = 'ShopEasy123!';

try {
    \$pdo = new PDO("mysql:host=\$host;dbname=\$dbname;charset=utf8mb4", \$username, \$password);
    \$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException \$e) {
    die("Database connection failed: " . \$e->getMessage());
}
?>
DBEOF

# register.php
cat > register.php << 'REGEOF'
<?php
require_once 'db_config.php';
header('Content-Type: application/json');

if (\$_SERVER['REQUEST_METHOD'] === 'POST') {
    \$firstName = trim(\$_POST['firstName']);
    \$lastName = trim(\$_POST['lastName']);
    \$email = trim(\$_POST['email']);
    \$password = \$_POST['password'];
    \$confirmPassword = \$_POST['confirmPassword'];
    
    \$errors = [];
    
    if (empty(\$firstName) || empty(\$lastName) || empty(\$email) || empty(\$password)) {
        \$errors[] = "All fields are required";
    }
    
    if (!filter_var(\$email, FILTER_VALIDATE_EMAIL)) {
        \$errors[] = "Invalid email format";
    }
    
    if (\$password !== \$confirmPassword) {
        \$errors[] = "Passwords do not match";
    }
    
    if (strlen(\$password) < 6) {
        \$errors[] = "Password must be at least 6 characters";
    }
    
    try {
        \$stmt = \$pdo->prepare("SELECT id FROM users WHERE email = ?");
        \$stmt->execute([\$email]);
        if (\$stmt->rowCount() > 0) {
            \$errors[] = "Email already registered";
        }
    } catch(PDOException \$e) {
        \$errors[] = "Database error";
    }
    
    if (empty(\$errors)) {
        try {
            \$hashedPassword = password_hash(\$password, PASSWORD_DEFAULT);
            \$stmt = \$pdo->prepare("INSERT INTO users (first_name, last_name, email, password) VALUES (?, ?, ?, ?)");
            
            if (\$stmt->execute([\$firstName, \$lastName, \$email, \$hashedPassword])) {
                \$response = ['success' => true, 'message' => 'Registration successful!'];
            } else {
                \$response = ['success' => false, 'message' => 'Registration failed'];
            }
        } catch(PDOException \$e) {
            \$response = ['success' => false, 'message' => 'Database error'];
        }
    } else {
        \$response = ['success' => false, 'message' => implode('<br>', \$errors)];
    }
    
    echo json_encode(\$response);
    exit;
}
?>
REGEOF

# login.php
cat > login.php << 'LOGEOF'
<?php
require_once 'db_config.php';
header('Content-Type: application/json');

if (\$_SERVER['REQUEST_METHOD'] === 'POST') {
    \$email = trim(\$_POST['email']);
    \$password = \$_POST['password'];
    
    \$errors = [];
    
    if (empty(\$email) || empty(\$password)) {
        \$errors[] = "Email and password are required";
    }
    
    if (empty(\$errors)) {
        try {
            \$stmt = \$pdo->prepare("SELECT id, first_name, last_name, email, password FROM users WHERE email = ?");
            \$stmt->execute([\$email]);
            \$user = \$stmt->fetch(PDO::FETCH_ASSOC);
            
            if (\$user && password_verify(\$password, \$user['password'])) {
                session_start();
                \$_SESSION['user_id'] = \$user['id'];
                \$_SESSION['user_name'] = \$user['first_name'] . ' ' . \$user['last_name'];
                \$_SESSION['user_email'] = \$user['email'];
                
                \$response = ['success' => true, 'message' => 'Login successful!'];
            } else {
                \$response = ['success' => false, 'message' => 'Invalid email or password'];
            }
        } catch(PDOException \$e) {
            \$response = ['success' => false, 'message' => 'Database error'];
        }
    } else {
        \$response = ['success' => false, 'message' => implode('<br>', \$errors)];
    }
    
    echo json_encode(\$response);
    exit;
}
?>
LOGEOF

# session.php
cat > session.php << 'SESSEOF'
<?php
session_start();

function isLoggedIn() {
    return isset(\$_SESSION['user_id']);
}

function getUserInfo() {
    if (isLoggedIn()) {
        return [
            'id' => \$_SESSION['user_id'],
            'name' => \$_SESSION['user_name'],
            'email' => \$_SESSION['user_email']
        ];
    }
    return null;
}

function requireLogin() {
    if (!isLoggedIn()) {
        header('Location: login.html');
        exit;
    }
}
?>
SESSEOF

# logout.php
cat > logout.php << 'LOGOEOF'
<?php
session_start();
session_destroy();
header('Location: index.html');
exit;
?>
LOGOEOF

echo "All PHP files created successfully!"
