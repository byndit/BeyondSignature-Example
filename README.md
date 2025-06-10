# BeyondSignature for Invoices - AL Code Integration Example

This repository contains an example implementation of the BeyondSignature integration for Microsoft Dynamics 365 Business Central, specifically designed for invoice signature capture and management.

## Overview

The **BeyondSignature for Invoices** extension demonstrates how to integrate digital signature functionality into Business Central using the BeyondSignature control add-in. This implementation follows best practices by having a single entry point for the signature control, ensuring consistent behavior across different client types (Web, Tablet, Phone).

## Architecture

### Single Entry Point Design

The implementation uses a **single signature page** ([`SignPad.Page.al`](src/SignPad.Page.al)) as the central entry point for all signature operations. This page is then embedded as a part in different locations of the Posted Sales Invoice page, ensuring:

- Consistent signature handling logic
- Reduced code duplication
- Easier maintenance and updates
- Unified user experience across platforms

### Key Components

#### 1. App Configuration ([`app.json`](app.json))
- **App ID**: `0e2c64c6-0081-42f3-be3d-88563f978442`
- **Publisher**: BEYONDIT GmbH
- **Version**: 2025.5.0.0
- **Dependencies**: BeyondSignature base app (`f776fc38-ca64-4d43-b868-3fb8c73cd7ff`)
- **ID Range**: 50241-50250
- **Target**: Cloud deployment

#### 2. Table Extension ([`SalesInvHeader.TableExt.al`](src/SalesInvHeader.TableExt.al))
Extends the `Sales Invoice Header` table with:
```al
field(50241; "ABC Signature"; Blob)
{
    Caption = 'Signature';
    Subtype = Bitmap;
}
```

#### 3. Signature Page ([`SignPad.Page.al`](src/SignPad.Page.al))
**Central signature handling component** that:
- Implements the BeyondSignature control add-in (`"BYD SIG Signature"`)
- Handles signature loading and saving operations
- Manages Base64 encoding/decoding for signature data
- Provides responsive configuration based on client type
- Supports localization with translatable labels

#### 4. Page Extension ([`PostedSalesInvoice.PageExt.al`](src/PostedSalesInvoice.PageExt.al))
Extends the `Posted Sales Invoice` page with responsive signature placement:
- **Factbox area**: For web clients
- **Content area**: For mobile clients (tablet/phone)

## Implementation Details

### Responsive Design

The implementation automatically adapts to different client types:

```al
trigger OnOpenPage()
begin
    VisibleForMobile := (CurrentClientType = ClientType::Tablet) or (CurrentClientType = ClientType::Phone);
    VisibleForWeb := CurrentClientType = ClientType::Web;
end;
```

### Signature Management

The signature page handles all signature operations through:

1. **Loading signatures**: Converts stored BLOB data to Base64 format
2. **Saving signatures**: Processes Base64 data and stores as BLOB
3. **Configuration**: Sets up control add-in with translations and read-only mode for web clients

### Control Add-in Integration

The BeyondSignature control add-in is configured with:
- **Translations**: Localized labels for Clear and Save buttons
- **Read-only mode**: Automatically enabled for web clients
- **Content management**: Handles signature data in Base64 format

## File Structure

```
├── app.json                           # App manifest and configuration
├── src/
│   ├── PostedSalesInvoice.PageExt.al  # Page extension for invoice display
│   ├── SalesInvHeader.TableExt.al     # Table extension for signature storage
│   └── SignPad.Page.al                # Central signature page (single entry point)
└── Translations/
    └── BeyondSignature for Invoices.g.xlf  # Translation file
```

## Key Features

### ✅ Single Entry Point
- One signature page handles all signature operations
- Consistent behavior across all client types
- Centralized signature logic

### ✅ Responsive Design
- Automatic adaptation to web, tablet, and phone clients
- Optimal placement for each device type
- Consistent user experience

### ✅ Data Management
- Secure BLOB storage for signature data
- Base64 encoding for web compatibility
- Automatic data conversion and validation

### ✅ Localization Support
- Translatable user interface elements
- Multi-language support (German, English)
- Extensible translation framework

## Prerequisites

1. **Microsoft Dynamics 365 Business Central** (version 24.0 or later)
2. **BeyondSignature base app** (version 2025.0.0.0 or later)
3. **AL Development Environment** with runtime 13.0

## Installation

1. Install the BeyondSignature base app dependency
2. Deploy this extension to your Business Central environment
3. The signature functionality will be automatically available on Posted Sales Invoice pages

## Usage

1. Navigate to any Posted Sales Invoice
2. The signature pad will appear in:
   - **Factbox area** (for web clients)
   - **Content area** (for mobile clients)
3. Users can draw signatures directly on the pad
4. Signatures are automatically saved and linked to the invoice

## Development Notes

### Best Practices Implemented

- **Single Responsibility**: Each component has a clear, focused purpose
- **DRY Principle**: No code duplication through centralized signature handling
- **Responsive Design**: Automatic adaptation to different client types
- **Error Handling**: Proper validation and error management
- **Localization**: Full support for multiple languages

### Extension Points

The implementation can be easily extended to:
- Support additional document types
- Add signature validation rules
- Implement approval workflows
- Add audit trail functionality

## Support

For technical support and additional information:
- **Website**: https://beyondit.gmbh
- **Publisher**: BEYONDIT GmbH
- **Documentation**: https://www.beyondit.gmbh/

## License

This example is provided by BEYONDIT GmbH as a reference implementation for BeyondSignature integration in Microsoft Dynamics 365 Business Central.