# Teletri API Documentation

## 🔌 Обзор API

Teletri предоставляет RESTful API для интеграции с интернет-магазинами и внешними системами.

## 🔐 Аутентификация

### API Key
```http
Authorization: Bearer YOUR_API_KEY
```

### Пример заголовка
```http
GET /api/v1/discounts/calc
Authorization: Bearer sk_live_1234567890abcdef
Content-Type: application/json
```

## 📋 Основные endpoints

### 1. Расчет скидок

#### POST /api/v1/discounts/calc

Вычисляет скидку на основе правил Liquid и данных заказа.

**Запрос:**
```json
{
  "order_lines": [
    {
      "product_id": 12345,
      "title": "Товар 1",
      "sale_price": 1000,
      "quantity": 2,
      "colls": ["Коллекция 1", "Коллекция 2"]
    }
  ],
  "total_price": 2000,
  "customer": {
    "id": 67890,
    "total_spent": 50000,
    "orders_count": 15
  }
}
```

**Ответ (скидка применена):**
```json
{
  "discount": 200,
  "discount_type": "MONEY",
  "title": "Скидка 10% на заказ от 2000 руб"
}
```

**Ответ (скидка не найдена):**
```json
{
  "errors": ["Скидка не найдена"]
}
```

### 2. Управление списками избранного

#### GET /api/v1/lists
Получить списки клиента.

**Ответ:**
```json
{
  "lists": [
    {
      "id": 1,
      "name": "Мои избранные",
      "items": [
        {
          "product_id": 12345,
          "title": "Товар 1",
          "price": 1000,
          "image_url": "https://example.com/image.jpg"
        }
      ]
    }
  ]
}
```

#### POST /api/v1/lists
Создать новый список.

**Запрос:**
```json
{
  "name": "Новый список",
  "description": "Описание списка"
}
```

#### POST /api/v1/lists/{id}/items
Добавить товар в список.

**Запрос:**
```json
{
  "product_id": 12345,
  "title": "Товар 1",
  "price": 1000
}
```

### 3. Уведомления о поступлении

#### POST /api/v1/restock/subscribe
Подписаться на уведомления о поступлении товара.

**Запрос:**
```json
{
  "product_id": 12345,
  "email": "customer@example.com",
  "phone": "+7900123456"
}
```

#### GET /api/v1/restock/subscriptions
Получить подписки клиента.

### 4. Предзаказы

#### POST /api/v1/preorders
Создать предзаказ.

**Запрос:**
```json
{
  "product_id": 12345,
  "customer_id": 67890,
  "quantity": 1,
  "contact_email": "customer@example.com"
}
```

### 5. Брошенные корзины

#### POST /api/v1/cart/abandoned
Отметить корзину как брошенную.

**Запрос:**
```json
{
  "cart_id": "cart_123",
  "customer_id": 67890,
  "items": [
    {
      "product_id": 12345,
      "quantity": 2,
      "price": 1000
    }
  ],
  "total_amount": 2000
}
```

## 🔄 Webhook API

### Настройка webhook
```json
{
  "url": "https://your-store.com/webhooks/teletri",
  "events": ["discount.applied", "restock.notification", "cart.abandoned"]
}
```

### События

#### discount.applied
```json
{
  "event": "discount.applied",
  "data": {
    "order_id": "order_123",
    "discount_amount": 200,
    "discount_type": "MONEY",
    "rule_id": 5
  },
  "timestamp": "2025-01-23T12:00:00Z"
}
```

#### restock.notification
```json
{
  "event": "restock.notification",
  "data": {
    "product_id": 12345,
    "subscriber_count": 15,
    "notification_sent": true
  },
  "timestamp": "2025-01-23T12:00:00Z"
}
```

## 📊 Аналитика API

### GET /api/v1/analytics/discounts
Статистика по скидкам.

**Ответ:**
```json
{
  "period": "2025-01-01 to 2025-01-31",
  "total_discounts_applied": 150,
  "total_discount_amount": 45000,
  "average_discount": 300,
  "conversion_rate": 0.15
}
```

### GET /api/v1/analytics/cart-recovery
Статистика восстановления корзин.

**Ответ:**
```json
{
  "period": "2025-01-01 to 2025-01-31",
  "abandoned_carts": 500,
  "recovered_carts": 175,
  "recovery_rate": 0.35,
  "recovered_amount": 87500
}
```

## 🛠️ SDK

### JavaScript SDK
```javascript
const teletri = new TeletriClient({
  apiKey: 'sk_live_1234567890abcdef',
  baseUrl: 'https://api.teletri.ru'
});

// Расчет скидки
const discount = await teletri.discounts.calc({
  order_lines: [...],
  total_price: 2000
});

// Добавление в избранное
await teletri.lists.addItem(listId, {
  product_id: 12345,
  title: 'Товар 1'
});
```

### PHP SDK
```php
$teletri = new TeletriClient([
    'api_key' => 'sk_live_1234567890abcdef',
    'base_url' => 'https://api.teletri.ru'
]);

// Расчет скидки
$discount = $teletri->discounts->calc([
    'order_lines' => [...],
    'total_price' => 2000
]);

// Добавление в избранное
$teletri->lists->addItem($listId, [
    'product_id' => 12345,
    'title' => 'Товар 1'
]);
```

## 📝 Коды ошибок

| Код | Описание |
|-----|----------|
| 200 | Успешный запрос |
| 400 | Неверный запрос |
| 401 | Не авторизован |
| 403 | Доступ запрещен |
| 404 | Ресурс не найден |
| 422 | Ошибка валидации |
| 500 | Внутренняя ошибка сервера |

## 🔒 Лимиты API

- **Базовый план**: 100 запросов/час
- **Профессиональный**: 1,000 запросов/час
- **Корпоративный**: Без лимитов

## 📞 Поддержка

- Email: api-support@teletri.ru
- Документация: https://docs.teletri.ru
- Статус API: https://status.teletri.ru

---

**Teletri API** - мощный инструмент для интеграции маркетинговых возможностей в ваш интернет-магазин.
