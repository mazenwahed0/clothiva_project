/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */
enum TextSizes { small, medium, large }

enum Orderstatus { processing, shipped, delivered, pending }

enum PaymentMethods {
  paypal,
  googlepay,
  applepay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
}

enum AppRole { admin, user }

enum Role {
  admin,
  manager,
  operator,
  fleetOwner,
  fleetManager,
  fleetOperator,
  driver,
  user,
  unknown
}

enum ChatType { support }

enum ChatMessageStatus { sending, sent, delivered, read, failed }

enum VerificationStatus {
  unknown,
  pending,
  submitted,
  underReview,
  approved,
  rejected
}

enum DiscountType { fixed, percentage }
