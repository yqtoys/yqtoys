<?php
// session.php - 会话管理
session_start();

function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

function getUserInfo() {
    if (isLoggedIn()) {
        return [
            'id' => $_SESSION['user_id'],
            'name' => $_SESSION['user_name'],
            'email' => $_SESSION['user_email']
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
