reportextension 50241 "ABC Sales Quote" extends "Standard Sales - Quote"
{
    WordLayout = '.\src\SalesQuoteWithSignature.docx';
    dataset
    {
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                Signature: Record "BYD SIG Signature";
                Instr: InStream;
            begin
                Signature.SetAutoCalcFields(Signature);
                Signature.SetRange(Id, Header.RecordId());
                if Signature.FindFirst() then begin
                    Signature.Signature.CreateInStream(Instr);
                    TempItem."Picture".ImportStream(Instr, Signature.Name);
                end;
            end;
        }
        add(Header)
        {
            column(ABCSignature; TempItem."Picture") { }
        }
    }

    var
        TempItem: Record Item temporary;
}