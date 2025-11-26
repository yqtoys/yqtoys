<?php
// check_login.php - 检查用户是否登录
session_start();

function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function getUserInfo() {
    if (isset($_SESSION['user_id'])) {
        return [
            'id' => $_SESSION['user_id'],
            'name' => $_SESSION['user_name'],
            'email' => $_SESSION['user_email']
        ];
    }
    return null;
}

function checkLogin() {
    if (!isLoggedIn()) {
        header('Location: login.html');
        exit;
    }
    return getUserInfo();
}

// 如果这个文件被直接包含，立即检查登录状态
if (basename(__FILE__) == basename($_SERVER['SCRIPT_FILENAME'])) {
    checkLogin();
}
?>
