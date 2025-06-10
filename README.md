# BeyondSignature for Invoices - Simple Integration Example

This repository contains a streamlined example implementation of the BeyondSignature integration for Microsoft Dynamics 365 Business Central, specifically designed for invoice signature capture.

## Overview

The **BeyondSignature for Invoices** extension demonstrates a simple and clean integration approach that leverages the BeyondSignature base app's built-in signature pad functionality. This implementation follows a minimalist approach by extending the Posted Sales Invoice page with a signature action that opens the signature pad provided by the BeyondSignature base app.

## Architecture

### Simplified Integration Approach

This implementation uses a **lightweight integration pattern** that:

- Leverages the existing signature pad from the BeyondSignature base app
- Adds a single action to the Posted Sales Invoice page
- Requires minimal custom code
- Provides maximum compatibility and maintainability

### Key Components

#### 1. App Configuration ([`app/app.json`](app/app.json))
- **App ID**: `0e2c64c6-0081-42f3-be3d-88563f978442`
- **Publisher**: BEYONDIT GmbH
- **Version**: 2025.5.0.0
- **Dependencies**: BeyondSignature base app (`f776fc38-ca64-4d43-b868-3fb8c73cd7ff`)
- **ID Range**: 50241-50250
- **Target**: Cloud deployment
- **Runtime**: 13.0

#### 2. Page Extension ([`app/src/PostedSalesInvoice.PageExt.al`](app/src/PostedSalesInvoice.PageExt.al))
Extends the `Posted Sales Invoice` page with:
- **Signature Action**: Adds a "Signature" button to the action bar
- **Action Reference**: Promotes the signature action for easy access
- **Modal Integration**: Opens the BeyondSignature pad in a modal dialog

```al
action("ABC Signature")
{
    ApplicationArea = All;
    Caption = 'Signature';
    ToolTip = 'Executes the Signature action.';
    Image = Signature;

    trigger OnAction()
    var
        SignaturePad: Page "BYD SIG Signature Pad";
    begin
        SignaturePad.Init(Rec.RecordId(), Rec."Ship-to Name", Rec."Ship-to City");
        SignaturePad.RunModal();
    end;
}
```

## Implementation Details

### Signature Integration

The implementation uses the BeyondSignature base app's signature pad:

1. **Action Trigger**: When users click the "Signature" action
2. **Page Initialization**: The signature pad is initialized with:
   - Record ID of the current invoice
   - Ship-to Name for context
   - Ship-to City for additional context
3. **Modal Display**: The signature pad opens as a modal dialog
4. **Data Handling**: All signature data management is handled by the base app

### Client Compatibility

The extension is designed to work across all client types:
- **Web Client**: Full functionality with mouse/touch input
- **Tablet**: Optimized for touch signature input
- **Phone**: Responsive design for mobile signature capture

## File Structure

```
├── app.json                           # App manifest and configuration
├── src/
│   └── PostedSalesInvoice.PageExt.al  # Page extension with signature action
└── Translations/
    └── BeyondSignature for Invoices.g.xlf  # Translation file
```

## Key Features

### ✅ Minimal Code Footprint
- Single page extension file
- Leverages existing BeyondSignature infrastructure
- No custom signature handling logic required

### ✅ Easy Maintenance
- Minimal custom code to maintain
- Updates handled by the BeyondSignature base app
- Simple integration pattern

### ✅ Full Functionality
- Complete signature capture capabilities
- Automatic data storage and retrieval
- Context-aware initialization

### ✅ Multi-Platform Support
- Works on web, tablet, and phone clients
- Responsive signature input
- Consistent user experience

## Prerequisites

1. **Microsoft Dynamics 365 Business Central** (version 24.0 or later)
2. **BeyondSignature base app** (version 2025.0.0.0 or later)
3. **AL Development Environment** with runtime 13.0

## Installation

1. Install the BeyondSignature base app dependency
2. Deploy this extension to your Business Central environment
3. The signature action will be automatically available on Posted Sales Invoice pages

## Usage

1. Navigate to any Posted Sales Invoice
2. Click the **"Signature"** action in the action bar
3. The BeyondSignature pad will open in a modal dialog
4. Users can capture signatures using mouse, touch, or stylus input
5. Signatures are automatically saved and linked to the invoice

## Development Notes

### Integration Benefits

- **Reduced Complexity**: No need to implement custom signature handling
- **Automatic Updates**: Signature functionality updates with the base app
- **Proven Reliability**: Uses tested and validated signature components
- **Consistent UX**: Maintains standard BeyondSignature user experience

### Extension Points

This simple integration can be easily extended to:
- Add signature actions to other document types
- Customize the signature pad initialization parameters
- Implement additional validation or workflow logic
- Add custom signature-related fields or processing

### Best Practices Demonstrated

- **Dependency Management**: Proper use of app dependencies
- **Minimal Footprint**: Lean implementation with maximum functionality
- **Standard Patterns**: Following AL development best practices
- **Localization Support**: Translation-ready implementation

## Support

For technical support and additional information:
- **Website**: https://beyondit.gmbh
- **Publisher**: BEYONDIT GmbH
- **Documentation**: https://www.beyondit.gmbh/

## License

This example is provided by BEYONDIT GmbH as a reference implementation for BeyondSignature integration in Microsoft Dynamics 365 Business Central.