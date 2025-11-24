package arora.moulik.springboot.carma.profile;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import arora.moulik.springboot.carma.register.User;
import arora.moulik.springboot.carma.register.UserRepository;
import arora.moulik.springboot.carma.transactionspage.Transaction;
import arora.moulik.springboot.carma.transactionspage.TransactionRepository;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@SessionAttributes("username")
public class ReportController {

    private UserRepository userRepo;
    private TransactionRepository transactionRepo;

    public ReportController(UserRepository userRepo, TransactionRepository transactionRepo) {
        this.userRepo = userRepo;
        this.transactionRepo = transactionRepo;
    }

    @PostMapping("/generate-statement")
    public void generateStatement(@RequestParam String startDate,
            @RequestParam String endDate,
            ModelMap model,
            HttpServletResponse response) throws DocumentException, IOException {
        String username = (String) model.get("username");
        User user = userRepo.findByUsername(username);

        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        // Parse dates
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(startDate, formatter);
        LocalDate end = LocalDate.parse(endDate, formatter);

        // Fetch transactions
        List<Transaction> allTransactions = transactionRepo.findByUsername(username);
        List<Transaction> filteredTransactions = allTransactions.stream()
                .filter(t -> !t.getDate().toLocalDate().isBefore(start) && !t.getDate().toLocalDate().isAfter(end))
                .toList();

        // Generate PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=statement_" + startDate + "_to_" + endDate + ".pdf");

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        // Add header with CARMA logo and styling
        addHeader(document, user);

        // Add account statement title
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("ACCOUNT STATEMENT", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Add statement period
        Font periodFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.GRAY);
        Paragraph period = new Paragraph(
                String.format("Statement Period: %s to %s", startDate, endDate),
                periodFont);
        period.setAlignment(Element.ALIGN_CENTER);
        period.setSpacingAfter(30);
        document.add(period);

        // Add account information
        addAccountInfo(document, user);

        // Add transactions table
        addTransactionsTable(document, filteredTransactions, user);

        // Add footer
        addFooter(document);

        document.close();
    }

    private void addHeader(Document document, User user) throws DocumentException {
        // Create header table
        PdfPTable headerTable = new PdfPTable(2);
        headerTable.setWidthPercentage(100);
        headerTable.setWidths(new float[] { 1, 1 });

        // Left side - CARMA logo
        PdfPCell logoCell = new PdfPCell();
        logoCell.setBorder(Rectangle.NO_BORDER);
        logoCell.setPadding(10);

        // Create CARMA logo with enhanced styling
        createCarmaLogo(logoCell);

        // Right side - Bank details
        PdfPCell bankCell = new PdfPCell();
        bankCell.setBorder(Rectangle.NO_BORDER);
        bankCell.setPadding(10);

        Font bankFont = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.GRAY);
        Paragraph bankInfo = new Paragraph(
                "CARMA Banking Corporation\nSecure Online Banking\nwww.carmabanking.moulikarora.tech", bankFont);
        bankInfo.setAlignment(Element.ALIGN_RIGHT);
        bankCell.addElement(bankInfo);

        headerTable.addCell(logoCell);
        headerTable.addCell(bankCell);

        document.add(headerTable);

        // Add separator line
        PdfPTable separatorTable = new PdfPTable(1);
        separatorTable.setWidthPercentage(100);
        PdfPCell separatorCell = new PdfPCell();
        separatorCell.setBorder(Rectangle.BOTTOM);
        separatorCell.setBorderWidthBottom(2);
        separatorCell.setBorderColorBottom(BaseColor.BLUE);
        separatorCell.setFixedHeight(2);
        separatorTable.addCell(separatorCell);
        document.add(separatorTable);
        document.add(new Paragraph("\n"));
    }

    private void addAccountInfo(Document document, User user) throws DocumentException {
        PdfPTable infoTable = new PdfPTable(2);
        infoTable.setWidthPercentage(100);
        infoTable.setWidths(new float[] { 1, 2 });
        infoTable.setSpacingAfter(20);

        Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.DARK_GRAY);
        Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.BLACK);

        // Account Holder
        PdfPCell labelCell = new PdfPCell(new Phrase("Account Holder:", labelFont));
        labelCell.setBorder(Rectangle.NO_BORDER);
        labelCell.setPadding(5);
        infoTable.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(user.getName() + " " + user.getSurname(), valueFont));
        valueCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setPadding(5);
        infoTable.addCell(valueCell);

        // Account Number
        labelCell = new PdfPCell(new Phrase("Account Number:", labelFont));
        labelCell.setBorder(Rectangle.NO_BORDER);
        labelCell.setPadding(5);
        infoTable.addCell(labelCell);

        valueCell = new PdfPCell(new Phrase(user.getaccount(), valueFont));
        valueCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setPadding(5);
        infoTable.addCell(valueCell);

        // Email
        labelCell = new PdfPCell(new Phrase("Email:", labelFont));
        labelCell.setBorder(Rectangle.NO_BORDER);
        labelCell.setPadding(5);
        infoTable.addCell(labelCell);

        valueCell = new PdfPCell(new Phrase(user.getEmail(), valueFont));
        valueCell.setBorder(Rectangle.NO_BORDER);
        valueCell.setPadding(5);
        infoTable.addCell(valueCell);

        document.add(infoTable);
    }

    private void addTransactionsTable(Document document, List<Transaction> transactions, User user)
            throws DocumentException {
        if (transactions.isEmpty()) {
            Font noDataFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.GRAY);
            Paragraph noData = new Paragraph("No transactions found for the selected period.", noDataFont);
            noData.setAlignment(Element.ALIGN_CENTER);
            noData.setSpacingAfter(20);
            document.add(noData);
            return;
        }

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new float[] { 2, 2, 3, 2, 2 });
        table.setSpacingBefore(10);

        // Table header
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
        BaseColor headerColor = new BaseColor(70, 130, 180); // Steel blue

        String[] headers = { "Date", "Type", "From/To", "Amount", "Balance" };

        for (String header : headers) {
            PdfPCell headerCell = new PdfPCell(new Phrase(header, headerFont));
            headerCell.setBackgroundColor(headerColor);
            headerCell.setPadding(8);
            headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(headerCell);
        }

        // Table data
        Font dataFont = FontFactory.getFont(FontFactory.HELVETICA, 9, BaseColor.BLACK);
        Font amountFont = FontFactory.getFont(FontFactory.HELVETICA, 9, BaseColor.BLACK);

        for (Transaction transaction : transactions) {
            // Date
            PdfPCell dateCell = new PdfPCell(new Phrase(
                    transaction.getDate().toLocalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")),
                    dataFont));
            dateCell.setPadding(6);
            dateCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(dateCell);

            // Type
            PdfPCell typeCell = new PdfPCell(new Phrase(transaction.getType(), dataFont));
            typeCell.setPadding(6);
            typeCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(typeCell);

            // From/To
            String fromTo = transaction.getType().equals("Credit") ? transaction.getSenderUsername()
                    : transaction.getRecipientUsername();
            PdfPCell fromToCell = new PdfPCell(new Phrase(fromTo, dataFont));
            fromToCell.setPadding(6);
            table.addCell(fromToCell);

            // Amount
            String amountStr = String.format("€%.2f", transaction.getAmount());
            PdfPCell amountCell = new PdfPCell(new Phrase(amountStr, amountFont));
            amountCell.setPadding(6);
            amountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(amountCell);

            // Balance (placeholder)
            String balanceStr = String.format("€%.2f", (double) user.getbalance());
            PdfPCell balanceCell = new PdfPCell(new Phrase(balanceStr, dataFont));
            balanceCell.setPadding(6);
            balanceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(balanceCell);
        }

        document.add(table);

        // Add summary
        Font summaryFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.DARK_GRAY);
        Paragraph summary = new Paragraph(
                String.format("Total Transactions: %d", transactions.size()),
                summaryFont);
        summary.setSpacingBefore(20);
        document.add(summary);
    }

    private void addFooter(Document document) throws DocumentException {
        document.add(new Paragraph("\n\n"));

        // Add footer line
        PdfPTable footerTable = new PdfPTable(1);
        footerTable.setWidthPercentage(100);
        PdfPCell footerCell = new PdfPCell();
        footerCell.setBorder(Rectangle.TOP);
        footerCell.setBorderWidthTop(1);
        footerCell.setBorderColorTop(BaseColor.LIGHT_GRAY);
        footerCell.setFixedHeight(1);
        footerTable.addCell(footerCell);
        document.add(footerTable);

        // Footer text
        Font footerFont = FontFactory.getFont(FontFactory.HELVETICA, 8, BaseColor.GRAY);
        Paragraph footer = new Paragraph(
                "This is a computer-generated statement and does not require a signature. " +
                        "Generated on "
                        + java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")),
                footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(10);
        document.add(footer);
    }

    private void createCarmaLogo(PdfPCell logoCell) throws DocumentException {
        // Create logo text with gradient-like effect using different colors
        Font logoFontC = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(102, 126, 234));
        Font logoFontA = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(118, 75, 162));
        Font logoFontR = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(102, 126, 234));
        Font logoFontM = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(118, 75, 162));

        // Create a table for the logo text with individual letter styling
        PdfPTable logoTable = new PdfPTable(5);
        logoTable.setWidthPercentage(100);
        logoTable.setWidths(new float[] { 1, 1, 1, 1, 1 });

        // C
        PdfPCell cCell = new PdfPCell(new Phrase("C", logoFontC));
        cCell.setBorder(Rectangle.NO_BORDER);
        cCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cCell.setPadding(2);
        logoTable.addCell(cCell);

        // A
        PdfPCell aCell = new PdfPCell(new Phrase("A", logoFontA));
        aCell.setBorder(Rectangle.NO_BORDER);
        aCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        aCell.setPadding(2);
        logoTable.addCell(aCell);

        // R
        PdfPCell rCell = new PdfPCell(new Phrase("R", logoFontR));
        rCell.setBorder(Rectangle.NO_BORDER);
        rCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        rCell.setPadding(2);
        logoTable.addCell(rCell);

        // M
        PdfPCell mCell = new PdfPCell(new Phrase("M", logoFontM));
        mCell.setBorder(Rectangle.NO_BORDER);
        mCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        mCell.setPadding(2);
        logoTable.addCell(mCell);

        // A
        PdfPCell a2Cell = new PdfPCell(new Phrase("A", logoFontA));
        a2Cell.setBorder(Rectangle.NO_BORDER);
        a2Cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        a2Cell.setPadding(2);
        logoTable.addCell(a2Cell);

        logoCell.addElement(logoTable);

        // Add geometric design elements
        PdfPTable designTable = new PdfPTable(3);
        designTable.setWidthPercentage(100);
        designTable.setWidths(new float[] { 1, 1, 1 });

        // Left geometric shape
        PdfPCell leftShape = new PdfPCell();
        leftShape.setBorder(Rectangle.NO_BORDER);
        leftShape.setFixedHeight(6);
        leftShape.setBackgroundColor(new BaseColor(102, 126, 234));
        designTable.addCell(leftShape);

        // Center shape
        PdfPCell centerShape = new PdfPCell();
        centerShape.setBorder(Rectangle.NO_BORDER);
        centerShape.setFixedHeight(6);
        centerShape.setBackgroundColor(new BaseColor(118, 75, 162));
        designTable.addCell(centerShape);

        // Right shape
        PdfPCell rightShape = new PdfPCell();
        rightShape.setBorder(Rectangle.NO_BORDER);
        rightShape.setFixedHeight(6);
        rightShape.setBackgroundColor(new BaseColor(102, 126, 234));
        designTable.addCell(rightShape);

        logoCell.addElement(designTable);

        // Add "BANKING" subtitle
        Font bankingFont = FontFactory.getFont(FontFactory.HELVETICA, 8, BaseColor.GRAY);
        Paragraph banking = new Paragraph("BANKING", bankingFont);
        banking.setAlignment(Element.ALIGN_LEFT);
        banking.setSpacingBefore(2);
        logoCell.addElement(banking);
    }
}
