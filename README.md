# 🛒 Acme Widget Co - Shopping Basket

## 📘 Overview

This is a **Ruby-based proof-of-concept shopping basket** for **Acme Widget Co.**  
It demonstrates simple yet extensible business logic for handling:

- Adding products to a basket
- Calculating **total**
- Applying **offers** (e.g., Buy One Get One Half Price)
- Calculating **delivery charges** after applying offers

---

## 🧠 Assumptions

- Only the following products are available:

| Product Name | Code | Price  |
| ------------ | ---- | ------ |
| Red Widget   | R01  | $32.95 |
| Green Widget | G01  | $24.95 |
| Blue Widget  | B01  | $7.95  |

- Delivery rules are **fixed** as follows:

  - Orders under **$50** → $4.95 delivery
  - Orders under **$90** → $2.95 delivery
  - Orders **$90 or more** → Free delivery

- Offers are **predefined** and currently limited to:
  - **Buy One Get One Half Price** on `R01` (Red Widget) and `G01` (Green Widget)

---

## ⚙️ Requirements

- **Ruby 3.0.0**
- **Bundler** (for dependency management)

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/bhagwanrajputror963-a11y/Acme-Widget-Co.git
cd  Acme-Widget-Co
```

### 2. Install dependencies

This project uses Bundler to manage test dependencies. If you don't have Bundler installed:

```bash
gem install bundler
```

Then install project dependencies:

```bash
bundle install
```

### 3. Run tests

Run all tests with:

```bash
bundle exec rspec
```

You can also run a single spec file:

```bash
bundle exec rspec spec/lib/basket_spec.rb
```
