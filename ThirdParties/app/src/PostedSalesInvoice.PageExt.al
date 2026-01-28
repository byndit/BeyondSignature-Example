pageextension 50241 "ABC Posted Sales Invoice" extends "Posted Sales Invoice"
{
    actions
    {
        addbefore("Print_Promoted")
        {
            actionref("ABC Signature ActionRef"; "ABC Signature") { }
        }

        addbefore(Print)
        {
            action("ABC Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                ToolTip = 'Executes the Signature action.';
                Image = Signature;
                Visible = VisibleForMobile;

                trigger OnAction()
                var
                    SignaturePad: Page "BYD SIG Signature Pad";
                begin
                    SignaturePad.Init(Rec.RecordId(), Rec."Ship-to Name", Rec."Ship-to City");
                    SignaturePad.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        VisibleForMobile := (CurrentClientType = ClientType::Tablet) or (CurrentClientType = ClientType::Phone) or (CurrentClientType = ClientType::Web);
    end;

    var
        VisibleForMobile: Boolean;
}