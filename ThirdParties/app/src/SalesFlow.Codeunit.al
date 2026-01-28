codeunit 50241 "ABC Sales Flow"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', false, false)]
    local procedure PurchQuoteToOrderOnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header")
    begin
        SignatureMgt.CopySignature(QuotePurchHeader.RecordId(), OrderPurchHeader.RecordId());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure PurchPostOnAfterDeleteAfterPosting(var PurchaseHeader: Record "Purchase Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var SkipDelete: Boolean)
    begin
        if SkipDelete then
            exit;

        case true of
            PurchInvHeader."No." <> '':
                SignatureMgt.CopySignature(PurchaseHeader.RecordId(), PurchInvHeader.RecordId());
            PurchCrMemoHdr."No." <> '':
                SignatureMgt.CopySignature(PurchaseHeader.RecordId(), PurchCrMemoHdr.RecordId());
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]
    local procedure SalesQuoteToOrderOnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header")
    begin
        SignatureMgt.CopySignature(QuoteSalesHeader.RecordId(), OrderSalesHeader.RecordId());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure SalesPostOnAfterDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean)
    begin
        if SkipDelete then
            exit;

        case true of
            SalesInvoiceHeader."No." <> '':
                SignatureMgt.CopySignature(SalesHeader.RecordId(), SalesInvoiceHeader.RecordId());
            SalesCrMemoHeader."No." <> '':
                SignatureMgt.CopySignature(SalesHeader.RecordId(), SalesCrMemoHeader.RecordId());
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Quote to Order", 'OnBeforeServLineDeleteAll', '', false, false)]
    local procedure ServiceQuoteToOrderOnBeforeServLineDeleteAll(var ServiceHeader: Record "Service Header"; var NewServiceHeader: Record "Service Header")
    begin
        SignatureMgt.CopySignature(ServiceHeader.RecordId(), NewServiceHeader.RecordId());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post", 'OnAfterPostServiceDoc', '', false, false)]
    local procedure ServicePostOnAfterPostServiceDoc(var ServiceHeader: Record "Service Header"; ServInvoiceNo: Code[20]; ServCrMemoNo: Code[20])
    var
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        OriginalServiceHeader: Record "Service Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
    begin
        if OriginalServiceHeader.Get(ServiceHeader."Document Type", ServiceHeader."No.") then
            exit;

        case true of
            ServiceInvoiceHeader.Get(ServInvoiceNo):
                SignatureMgt.CopySignature(ServiceHeader.RecordId(), ServiceInvoiceHeader.RecordId());
            ServiceCrMemoHeader.Get(ServCrMemoNo):
                SignatureMgt.CopySignature(ServiceHeader.RecordId(), ServiceCrMemoHeader.RecordId());
        end;
    end;

    var
        SignatureMgt: Codeunit "BYD SIG Signature Mgt.";
}