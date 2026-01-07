# Required Stimulus Controllers

This gem does **not** include JavaScript. The host application must provide Stimulus 3.x controllers registered under these names.

## Required Controllers

| Controller | Purpose | Targets | Values | Outlets |
|------------|---------|---------|--------|---------|
| `input` | Floating label inputs | `field` | - | - |
| `validate` | Form validation | `required`, `country`, `errorMessage` | - | - |
| `cart` | Shopping cart +/- | `quantity` | - | `sidebar-summary` |
| `codes` | Discount/gift codes | `input`, `form` | `url`, `invalidCode` | `sidebar-summary`, `sidebar-products` |
| `sidebar-summary` | Order totals | - | `summaryUrl` | - |
| `sidebar-products` | Product list | - | `orderItemsUrl` | - |
| `details` | Customer details | `email`, `loginNotification`, `loginLink`, `separateDeliveryAddress`, `deliveryAddress` | `loginPopup`, `existingCustomerAccountPath` | - |
| `address-book` | Saved addresses | - | - | - |
| `delivery-date` | Expected delivery | `date` | `url` | - |
| `waiting` | Payment waiting | - | - | - |
| `analytics` | GA/tracking | - | - | - |

## Optional Controllers (extend functionality)

| Controller | Purpose | Notes |
|------------|---------|-------|
| `address` | NL postcode autocomplete | Add to `_address_fields` override |
| `modal` | Login modal | Targets: `firstInput` |
| `login` | Login form | - |
| `pakjegemak` | PostNL pickup points | - |
| `dhl-servicepoints` | DHL pickup points | - |
| `ideal` | iDEAL bank select | - |
| `date` | Date input formatting | Targets: `field` |

## Example Registration (host app)

```javascript
// app/javascript/controllers/index.js
import { application } from "./application"

import InputController from "./checkout/input_controller"
import ValidateController from "./checkout/validate_controller"
import CartController from "./checkout/cart_controller"
import CodesController from "./checkout/codes_controller"
import SidebarSummaryController from "./checkout/sidebar_summary_controller"
import SidebarProductsController from "./checkout/sidebar_products_controller"
import DetailsController from "./checkout/details_controller"
import AddressBookController from "./checkout/address_book_controller"
import DeliveryDateController from "./checkout/delivery_date_controller"
import WaitingController from "./checkout/waiting_controller"

application.register("input", InputController)
application.register("validate", ValidateController)
application.register("cart", CartController)
application.register("codes", CodesController)
application.register("sidebar-summary", SidebarSummaryController)
application.register("sidebar-products", SidebarProductsController)
application.register("details", DetailsController)
application.register("address-book", AddressBookController)
application.register("delivery-date", DeliveryDateController)
application.register("waiting", WaitingController)
```

## Data Attribute Syntax

This gem uses **Stimulus 3.x** syntax:

```haml
-# Controller
data: {controller: "cart"}

-# Target
data: {"cart-target": "quantity"}

-# Value
data: {"sidebar-summary-summary-url-value": sidebar_summary_url}

-# Outlet
data: {"cart-sidebar-summary-outlet": ".sidebar-summary"}

-# Action
data: {action: "input->cart#addToCart change->cart#addToCart"}
```
