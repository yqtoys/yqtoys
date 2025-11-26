<?php
require_once 'db_config.php';

echo "<h2>Delete User</h2>";

// 获取要删除的用户ID
$user_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($user_id > 0) {
    try {
        // 先获取用户信息（用于确认）
        $stmt = $pdo->prepare("SELECT first_name, last_name, email FROM users WHERE id = ?");
        $stmt->execute([$user_id]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user) {
            // 删除用户
            $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
            $stmt->execute([$user_id]);
            
            echo "<p style='color: green;'>Successfully deleted user: {$user['first_name']} {$user['last_name']} ({$user['email']})</p>";
        } else {
            echo "<p style='color: red;'>User not found with ID: $user_id</p>";
        }
    } catch(PDOException $e) {
        echo "<p style='color: red;'>Error deleting user: " . $e->getMessage() . "</p>";
    }
} else {
    echo "<p>Please provide a valid user ID</p>";
}

// 显示剩余用户
echo "<h3>Remaining Users:</h3>";
try {
    $stmt = $pdo->query("SELECT id, first_name, last_name, email FROM users ORDER BY id");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (count($users) > 0) {
        echo "<table border='1' cellpadding='8'>";
        echo "<tr><th>ID</th><th>Name</th><th>Email</th><th>Action</th></tr>";
        foreach ($users as $user) {
            echo "<tr>";
            echo "<td>{$user['id']}</td>";
            echo "<td>{$user['first_name']} {$user['last_name']}</td>";
            echo "<td>{$user['email']}</td>";
            echo "<td><a href='delete_user.php?id={$user['id']}' onclick='return confirm(\"Delete {$user['first_name']} {$user['last_name']}?\")' style='color: red;'>Delete</a></td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No users found.</p>";
    }
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

echo "<p><a href='view_users.php'>View Users</a> | <a href='index.html'>Home</a></p>";
?>
