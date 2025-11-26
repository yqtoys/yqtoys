<?php
require_once 'db_config.php';

echo "<h2>User Management</h2>";

// 处理删除操作
if (isset($_POST['delete_user'])) {
    $user_id = intval($_POST['user_id']);
    if ($user_id > 0) {
        try {
            $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
            $stmt->execute([$user_id]);
            echo "<p style='color: green;'>User deleted successfully!</p>";
        } catch(PDOException $e) {
            echo "<p style='color: red;'>Error deleting user: " . $e->getMessage() . "</p>";
        }
    }
}

// 显示用户列表
try {
    $stmt = $pdo->query("SELECT id, first_name, last_name, email, created_at FROM users ORDER BY id");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (count($users) > 0) {
        echo "<form method='post'>";
        echo "<table border='1' cellpadding='8' style='border-collapse: collapse; width: 100%;'>";
        echo "<tr style='background-color: #f2f2f2;'>";
        echo "<th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Registered</th><th>Action</th>";
        echo "</tr>";
        
        foreach ($users as $user) {
            echo "<tr>";
            echo "<td>{$user['id']}</td>";
            echo "<td>{$user['first_name']}</td>";
            echo "<td>{$user['last_name']}</td>";
            echo "<td>{$user['email']}</td>";
            echo "<td>{$user['created_at']}</td>";
            echo "<td>";
            echo "<input type='hidden' name='user_id' value='{$user['id']}'>";
            echo "<button type='submit' name='delete_user' onclick='return confirm(\"Are you sure you want to delete {$user['first_name']} {$user['last_name']}?\")' style='background: red; color: white; border: none; padding: 5px 10px; cursor: pointer;'>Delete</button>";
            echo "</td>";
            echo "</tr>";
        }
        echo "</table>";
        echo "</form>";
        
        echo "<p><strong>Total users:</strong> " . count($users) . "</p>";
    } else {
        echo "<p>No users found in the database.</p>";
    }
    
} catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

echo "<hr>";
echo "<h3>Quick Actions</h3>";
echo "<p><a href='register.html'>Register New User</a></p>";
echo "<p><a href='view_users.php'>View All Users</a></p>";
echo "<p><a href='index.html'>Back to Home</a></p>";
?>
