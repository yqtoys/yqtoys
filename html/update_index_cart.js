// 这个脚本会更新主页的购物车功能
document.addEventListener('DOMContentLoaded', function() {
    // 更新所有"加入购物车"按钮
    document.querySelectorAll('.btn-cart').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            addToCart(productId, 1);
        });
    });
});

function addToCart(productId, quantity = 1) {
    <?php if ($logged_in): ?>
        const formData = new FormData();
        formData.append('product_id', productId);
        formData.append('quantity', quantity);
        
        fetch('add_to_cart.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                // 更新购物车数量显示
                updateCartCount(data.cart_count);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Failed to add item to cart');
        });
    <?php else: ?>
        alert('Please login to add items to cart.');
        window.location.href = 'login.html';
    <?php endif; ?>
}

function updateCartCount(count) {
    // 更新页面上的购物车数量显示
    const cartElements = document.querySelectorAll('.nav-links a[href="cart.php"]');
    cartElements.forEach(element => {
        element.innerHTML = element.innerHTML.replace(/Cart \(\d+\)/, `Cart (${count})`);
        if (!element.innerHTML.includes('Cart (')) {
            element.innerHTML = element.innerHTML.replace('Cart', `Cart (${count})`);
        }
    });
}
