# BeyondSignature for Invoices - Integration Example

This repository contains an example implementation of the BeyondSignature integration for Microsoft Dynamics 365 Business Central, demonstrating signature capture, document flow, and report integration.

## Overview

The **BeyondSignature for Invoices** extension demonstrates how to integrate with the BeyondSignature base app to:

- Capture digital signatures on documents
- Flow signatures from quotes to orders to posted documents
- Include signatures in custom report layouts

## Screenshots

### Capturing Signatures on Sales Quotes

The Signature Pad FactBox allows users to capture customer signatures directly on document pages:

![Sales Quote with Signature Pad](app/docs/signature-pad-capture.png)

### Custom Report Layout Selection

A custom Word layout extends the standard Sales Quote report to include the captured signature:

![Report Layouts](app/docs/report-layouts.png)

### Printing with the Signature Layout

Select the custom `SalesQuoteWithSignature.docx` layout when printing:

![Print Dialog](app/docs/print-dialog.png)

### Final Document Output

The printed document displays the captured signature:

![Sales Quote with Signature](app/docs/printed-document.png)

## Features

### Signature Capture

Add signature actions to any document page that opens the BeyondSignature pad:

```al
action("ABC Signature")
{
    ApplicationArea = All;
    Caption = 'Signature';
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

### Document Flow

Signatures automatically flow when documents are converted:

| Source Document | Target Document |
|-----------------|-----------------|
| Sales Quote | Sales Order |
| Sales Order | Posted Sales Invoice / Credit Memo |
| Purchase Quote | Purchase Order |
| Purchase Order | Posted Purchase Invoice / Credit Memo |
| Service Quote | Service Order |
| Service Order | Posted Service Invoice / Credit Memo |

### Report Integration

Include signatures in custom report layouts using a report extension:

```al
reportextension 50241 "ABC Sales Quote" extends "Standard Sales - Quote"
{
    WordLayout = '.\src\SalesQuoteWithSignature.docx';
    dataset
    {
        add(Header)
        {
            column(ABCSignature; TempItem."Picture") { }
        }
    }
}
```

## File Structure

```
app/
├── app.json                              # App manifest
├── SignFlow.PermissionSet.al             # Permission set
├── docs/                                 # Documentation images
└── src/
    ├── PostedSalesInvoice.PageExt.al     # Signature action on Posted Sales Invoice
    ├── SalesFlow.Codeunit.al             # Document flow handling
    ├── SalesQuote.ReportExt.al           # Report extension with signature
    └── SalesQuoteWithSignature.docx      # Custom Word layout
```

## Prerequisites

- Microsoft Dynamics 365 Business Central (version 24.0 or later)
- BeyondSignature base app (version 2025.0.0.0 or later)

## Installation

1. Install the BeyondSignature base app
2. Deploy this extension to your Business Central environment
3. The signature action will be available on Posted Sales Invoice pages
4. Select the custom report layout in Report Layouts for Sales Quotes

## Usage

### Capturing a Signature

1. Open a document (e.g., Sales Quote, Posted Sales Invoice)
2. Click the **Signature** action
3. Have the customer sign on the Signature Pad
4. Close the pad to save

### Printing with Signatures

1. Navigate to **Report Layouts** and select the `SalesQuoteWithSignature` layout for report 1304
2. Open a Sales Quote with a captured signature
3. Click **Print** and select the custom layout
4. The signature appears on the printed document

## Client Compatibility

The extension works across all client types:
- **Web Client**: Mouse and touch input
- **Tablet**: Optimized for touch signature input
- **Phone**: Responsive mobile signature capture

## Support

- **Website**: https://beyond365.de
- **Publisher**: BEYONDIT GmbH
- **Documentation**: https://www.beyondit.gmbh/

## License

Copyright BEYONDIT GmbH. All rights reserved.
