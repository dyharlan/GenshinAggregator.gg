/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Utilities;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.codec.PngImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author csean
 */
public class ReportServlet extends HttpServlet {

    private final String NONE = "this is none ok??????";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf;charset=utf-8");
        response.setHeader("Accept-Ranges", "bytes");
        OutputStream out = response.getOutputStream();
        HttpSession session = request.getSession();
        //ByteArrayInputStream bais = ReportGenerator.generateReport(map, user, reportType, out);
        String ipAddress = InetAddress.getLocalHost().getHostAddress();
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath();
        String path1 = baseURL + "/assets/zh-cn.ttf";
        System.out.println(path1);
        FontFactory.register(path1, "Zhongli");
        String path2 = baseURL + "/assets/fonts/SourceSansPro-Bold.ttf";
        System.out.println(path2);
        FontFactory.register(path2, "Calibri Bold");
        String path3 = baseURL + "/assets/fonts/Calibri-Bold.ttf";
        System.out.println("Inside the method");
        Font[] fonts = {
            FontFactory.getFont("Zhongli", BaseFont.IDENTITY_H, true, 11, Font.NORMAL),
            FontFactory.getFont("Zhongli", BaseFont.IDENTITY_H, true, 36, Font.BOLD),
            FontFactory.getFont("Zhongli", BaseFont.IDENTITY_H, true, 26, Font.UNDERLINE),
            FontFactory.getFont("Zhongli", BaseFont.IDENTITY_H, true, 26, Font.NORMAL),};
        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
//            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("Sample Report.pdf")); //ByteArrayOutputStream
//            ByteArrayOutputStream temp = new ByteArrayOutputStream(); //this is where the pdf will first be stored as a byte array, output stream since this is a binary file
            PdfWriter writer = PdfWriter.getInstance(document, baos); //temp);
            Rectangle rect = new Rectangle(Utilities.inchesToPoints(11.69f), Utilities.inchesToPoints(6.69f));
            document.setPageSize(rect);
            document.open();

            Paragraph title;
            //String role = records.getString("USERROLE")
            //if (role.equals("Admin") || role.equals("ADMIN") || role.equals("admin"))
            title = new Paragraph("Receipt", fonts[1]);
            PdfContentByte pcb = writer.getDirectContent();
            BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            ColumnText.showTextAligned(pcb, Element.ALIGN_LEFT,
                    title,
                    document.left() + document.leftMargin(),
                    //                        document.left()*3 + document.leftMargin(),
                    document.top() - document.topMargin(), 0);
//            title.setAlignment(Element.ALIGN_LEFT);
            //title.
            //document.add(title);

//            String url = ipAddress + request.getContextPath() + "/assets/ConaShop-Logo.png";
            //System.out.println(url);
            URL imgURL = new URL("http", ipAddress, 8080, request.getContextPath() + "/assets/ConaShop-AlterLogo.png");
            System.out.println(imgURL.toString());
            Image img = PngImage.getImage(imgURL.openStream());
//            img.setAlignment(Element.ALIGN_RIGHT);
            img.scaleAbsolute(190.8f, 42f);
            img.setAbsolutePosition(document.right() - 225, document.top() - document.topMargin());
            document.add(img);
//            document.newPage();
            Paragraph spacing = new Paragraph("\n\n\n\n\n");
            document.add(spacing);
            //table section
            PdfPTable table = new PdfPTable(6);
            PdfPCell columnOne = new PdfPCell();
            Paragraph contentOne = new Paragraph("Transaction ID", fonts[0]);
            contentOne.setAlignment(Element.ALIGN_CENTER);
            columnOne.addElement(contentOne);
            table.addCell(columnOne);
            PdfPCell columnTwo = new PdfPCell();
            Paragraph contentTwo = new Paragraph("Recipient", fonts[0]);
            contentTwo.setAlignment(Element.ALIGN_CENTER);
            columnTwo.addElement(contentTwo);
            table.addCell(columnTwo);
            PdfPCell columnThree = new PdfPCell();
            Paragraph contentThree = new Paragraph("Item Name", fonts[0]);
            contentThree.setAlignment(Element.ALIGN_CENTER);
            columnThree.addElement(contentThree);
            table.addCell(columnThree);
            PdfPCell columnFour = new PdfPCell();
            Paragraph contentFour = new Paragraph("Payment Type", fonts[0]);
            contentFour.setAlignment(Element.ALIGN_CENTER);
            columnFour.addElement(contentFour);
            table.addCell(columnFour);
            PdfPCell columnFive = new PdfPCell();
            Paragraph contentFive = new Paragraph("Transaction Date", fonts[0]);
            contentFive.setAlignment(Element.ALIGN_CENTER);
            columnFive.addElement(contentFive);
            table.addCell(columnFive);
            PdfPCell columnSix = new PdfPCell();
            Paragraph contentSix = new Paragraph("Item Value", fonts[0]);
            contentSix.setAlignment(Element.ALIGN_CENTER);
            columnSix.addElement(contentSix);

            Class.forName(getServletContext().getInitParameter("className"));
            //System.out.println("jdbcClassName: " + config.getInitParameter("jdbcClassName"));
            String username = getServletContext().getInitParameter("dbUsername");
            String password = getServletContext().getInitParameter("dbPassword");
            StringBuffer DBurl = new StringBuffer(getServletContext().getInitParameter("driverURL"))
                    .append("://")
                    .append(getServletContext().getInitParameter("dbHostName"))
                    .append(":")
                    .append(getServletContext().getInitParameter("dbPort"))
                    .append("/")
                    .append(getServletContext().getInitParameter("dbName"));
            System.out.println(password);
            Connection conn = DriverManager.getConnection(DBurl.toString(), username, password);
            PreparedStatement ps1;
            ResultSet rs;
            String transactionQuery = "select usertransactions.transactionid,personCredentials.EMAIL,personinfo.FNAME, personinfo.LNAME,transactioninfo.itemrecipient,transactioninfo.itemid,inventory.itemname,usertransactions.paymenttype,paymentmethods.paymentname,usertransactions.transactiondate,inventory.itemvalue from personcredentials join personinfo using(userid) join usertransactions using(userid) join paymentmethods using(paymenttype) join transactioninfo using(transactionid) join inventory using(itemid) WHERE TRANSACTIONID = ?";
            ps1 = conn.prepareStatement(transactionQuery);
            String transactionID = (String) session.getAttribute("transactionID");
            if (transactionID == null) {
                response.sendRedirect(request.getContextPath() + "/Store/index.jsp");
                return;
            }
            ps1.setString(1, transactionID);
            rs = ps1.executeQuery();
            while (rs.next()) {
                table.addCell(columnSix);
                    contentOne = new Paragraph(rs.getString("transactionid").trim(), fonts[0]);
                    contentOne.setAlignment(Element.ALIGN_CENTER);
                    columnOne = new PdfPCell();
                    columnOne.addElement(contentOne); //note that columnOne may have two elements onwards
                    table.addCell(columnOne);
                    contentTwo = new Paragraph(rs.getString("itemrecipient").trim(), fonts[0]);
                    contentTwo.setAlignment(Element.ALIGN_CENTER);
                    columnTwo = new PdfPCell();
                    columnTwo.addElement(contentTwo);
                    table.addCell(columnTwo);
                    contentThree = new Paragraph(rs.getString("itemname").trim(), fonts[0]);
                    contentThree.setAlignment(Element.ALIGN_CENTER);
                    columnThree = new PdfPCell();
                    columnThree.addElement(contentThree);
                    table.addCell(columnThree);
                    contentFour = new Paragraph(rs.getString("paymentname").trim(), fonts[0]);
                    contentFour.setAlignment(Element.ALIGN_CENTER);
                    columnFour = new PdfPCell();
                    columnFour.addElement(contentFour);
                    table.addCell(columnFour);
                    contentFive = new Paragraph(rs.getDate("transactiondate").toString(), fonts[0]);
                    contentFive.setAlignment(Element.ALIGN_CENTER);
                    columnFive = new PdfPCell();
                    columnFive.addElement(contentFive);
                    table.addCell(columnFive);
                    contentSix = new Paragraph("₱P"+rs.getInt("ItemValue"), fonts[0]); //₱ or \u20B1
                    contentSix.setAlignment(Element.ALIGN_CENTER);
                    columnSix = new PdfPCell();
                    columnSix.addElement(contentSix);
                table.addCell(columnSix);
                table.setWidthPercentage(100);
                document.add(table);
                int currentSalesTax = Integer.parseInt(getServletContext().getInitParameter("salesTax"));
                Paragraph salesTax = new Paragraph("Sales Tax: P".concat(Integer.toString(currentSalesTax)), fonts[2]);
                salesTax.setAlignment(Element.ALIGN_RIGHT);
                document.add(salesTax);

                Paragraph total = new Paragraph("Total: P"+ Integer.valueOf(rs.getInt("ItemValue") + currentSalesTax), fonts[3]);
                total.setAlignment(Element.ALIGN_RIGHT);
                document.add(total);
            }

            document.close();

            System.out.println("document completed");

//            ByteArrayInputStream pdfToStamp = new ByteArrayInputStream(baos.toByteArray());
//            PdfReader reader = new PdfReader(pdfToStamp);
//            System.out.println("report is read");
//            int n = reader.getNumberOfPages();
//            PdfStamper stamper;
//            stamper = new PdfStamper(reader, baos);
//            PdfContentByte pagecontent;
//            for (int i = 0; i < n; ) {  
//                pagecontent = stamper.getOverContent(++i); //because i is incremented here, it's no longer necessary to add it on the for loop itself
//                if (i == 1)
//                {
//                    
//                }
//                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
//                LocalDateTime now = LocalDateTime.now();
//                Phrase dateAndTimeGenerated = new Phrase("Date and Time Generated: " + dtf.format(now), fonts[2]);
//                Phrase generatedBy = new Phrase("Generated By: " + user,fonts[2]);
//                Phrase pageXOfY = new Phrase("Page " + i + " of " + n, fonts[2]);
//                ColumnText.showTextAligned(pagecontent, Element.ALIGN_LEFT,
//                        dateAndTimeGenerated,
//                        document.left() + document.leftMargin(),
//                        //document.left()*3 + document.leftMargin(),
//                        document.bottom() - 12, 0);
//                ColumnText.showTextAligned(pagecontent, Element.ALIGN_LEFT, 
//                        generatedBy, 
//                        document.left() + document.leftMargin(), 
//                        document.bottom() - 24, 0);
//                ColumnText.showTextAligned(pagecontent, Element.ALIGN_RIGHT,
//                        pageXOfY,
//                        document.right() - document.rightMargin(),
//                        document.bottom() - 15, 0);
//            }
//            stamper.close();
//            reader.close();
//            System.out.println("report completed");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, e.toString());
        }

        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        byte[] byteArray = new byte[1024];
        int lengthOfBytes;
        while ((lengthOfBytes = bais.read(byteArray)) != -1) {
            out.write(byteArray, 0, lengthOfBytes);
        }
        out.flush();
        out.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
