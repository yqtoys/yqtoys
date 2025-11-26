<?php
header('Content-Type: text/html; charset=utf-8');

// 默认设置
$default_interval = 1;
$default_motor_time = 1;

// 处理POST请求
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current_content = file_exists('status.txt') ? file('status.txt', FILE_IGNORE_NEW_LINES) : ['OFF', $default_interval, $default_motor_time];
    $status = trim($current_content[0] ?? 'OFF');
    
    if (isset($_POST['interval'])) {
        $new_interval = intval($_POST['interval']);
        if ($new_interval < 1 || $new_interval > 86400) $new_interval = $default_interval;
        $current_motor_time = intval($current_content[2] ?? $default_motor_time);
        file_put_contents('status.txt', $status . "\n" . $new_interval . "\n" . $current_motor_time);
    }
    
    if (isset($_POST['motor_time'])) {
        $new_motor_time = intval($_POST['motor_time']);
        if ($new_motor_time < 1 || $new_motor_time > 30) $new_motor_time = $default_motor_time;
        $current_interval = intval($current_content[1] ?? $default_interval);
        file_put_contents('status.txt', $status . "\n" . $current_interval . "\n" . $new_motor_time);
    }
    
    header('Location: ' . $_SERVER['PHP_SELF']);
    exit;
}

// 处理GET请求 - 确保写入英文
if (isset($_GET['action'])) {
    $action = $_GET['action'];
    // 重要：这里直接使用英文ON/OFF
    $status = ($action === 'on') ? 'ON' : 'OFF';
    
    $current_interval = $default_interval;
    $current_motor_time = $default_motor_time;
    if (file_exists('status.txt')) {
        $lines = file('status.txt', FILE_IGNORE_NEW_LINES);
        if (count($lines) >= 2) $current_interval = intval(trim($lines[1]));
        if (count($lines) >= 3) $current_motor_time = intval(trim($lines[2]));
    }
    
    // 重要：写入英文ON/OFF
    file_put_contents('status.txt', $status . "\n" . $current_interval . "\n" . $current_motor_time);
    header('Location: ' . $_SERVER['PHP_SELF']);
    exit;
}

// 读取当前设置
$current_status = 'OFF';
$current_interval = $default_interval;
$current_motor_time = $default_motor_time;

if (file_exists('status.txt')) {
    $lines = file('status.txt', FILE_IGNORE_NEW_LINES);
    $current_status = trim($lines[0] ?? 'OFF');
    if (count($lines) >= 2) $current_interval = intval(trim($lines[1]));
    if (count($lines) >= 3) $current_motor_time = intval(trim($lines[2]));
}

if (!file_exists('status.txt')) {
    file_put_contents('status.txt', 'OFF' . "\n" . $default_interval . "\n" . $default_motor_time);
}
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>智能开关控制</title>
    <style>
        body { font-family: "Microsoft YaHei", Arial, sans-serif; text-align: center; margin: 50px; background: #f5f5f5; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); display: inline-block; max-width: 500px; }
        .btn { display: inline-block; padding: 20px 40px; font-size: 20px; margin: 10px; text-decoration: none; border: none; border-radius: 5px; cursor: pointer; transition: all 0.3s; }
        .on { background: #4CAF50; color: white; }
        .on:hover { background: #45a049; }
        .off { background: #f44336; color: white; }
        .off:hover { background: #da190b; }
        .status { font-size: 24px; margin: 20px; padding: 15px; border-radius: 5px; }
        .status-on { background: #4CAF50; color: white; }
        .status-off { background: #f44336; color: white; }
        .setting-form { margin: 20px; padding: 15px; background: #f9f9f9; border-radius: 5px; }
        .setting-form input, .setting-form button { padding: 10px; font-size: 16px; margin: 5px; border: 1px solid #ddd; border-radius: 4px; }
        .setting-form input { width: 100px; text-align: center; }
        .setting-form button { background: #2196F3; color: white; border: none; cursor: pointer; padding: 10px 15px; }
        .setting-form button:hover { background: #0b7dda; }
        .setting-group { margin: 15px 0; }
        .current-settings { margin: 15px 0; font-size: 16px; color: #666; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔌 智能开关控制</h1>
        
        <!-- 当前状态显示（中文） -->
        <div class="status <?php echo $current_status == 'ON' ? 'status-on' : 'status-off'; ?>">
            <?php
            // 显示中文，但数据来自英文status.txt
            if ($current_status == 'ON') {
                echo '✅ 当前状态: 开启';
            } else {
                echo '❌ 当前状态: 关闭';
            }
            ?>
        </div>
        
        <!-- 当前设置显示（中文） -->
        <div class="current-settings">
            <div>🕒 检查间隔: <strong><?php echo $current_interval; ?> 秒</strong></div>
            <div>⚙️ 电机运行时间: <strong><?php echo $current_motor_time; ?> 秒</strong></div>
        </div>
        
        <!-- 开启/关闭 控制按钮（中文） -->
        <div>
            <a href="?action=on" class="btn on">开启开关</a>
            <a href="?action=off" class="btn off">关闭开关</a>
        </div>
        
        <!-- 设置表单（中文） -->
        <div class="setting-form">
            <h3>系统设置</h3>
            
            <!-- 检查间隔设置 -->
            <div class="setting-group">
                <form method="POST">
                    <label for="interval">检查间隔 (秒):</label><br>
                    <input type="number" name="interval" id="interval" min="1" max="86400" value="<?php echo $current_interval; ?>">
                    <button type="submit">设置间隔</button>
                    <br><small>ESP8266检查指令的频率 (1-86400秒)</small>
                </form>
            </div>
            
            <!-- 电机运行时间设置 -->
            <div class="setting-group">
                <form method="POST">
                    <label for="motor_time">电机运行时间 (秒):</label><br>
                    <input type="number" name="motor_time" id="motor_time" min="1" max="30" value="<?php echo $current_motor_time; ?>">
                    <button type="submit">设置电机时间</button>
                    <br><small>推杆伸出/收回的运行时间 (1-30秒)</small>
                </form>
            </div>
        </div>
        
        <!-- 调试链接（中文） -->
        <div style="margin-top: 20px;">
            <a href="status.txt" target="_blank" style="color: #666; text-decoration: none;">📄 查看 status.txt 文件</a>
        </div>
    </div>
</body>
</html>