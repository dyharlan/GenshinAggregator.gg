/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author csean
 */
public class ReportServlet extends HttpServlet {

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
        response.setContentType("application/pdf");
        response.setHeader("Accept-Ranges", "bytes");
        OutputStream out = response.getOutputStream();
        HttpSession session = request.getSession();
        Map<String,String> map = (LinkedHashMap) session.getAttribute("result");
        String user = String.valueOf(session.getAttribute("user"));
        //ByteArrayInputStream bais = ReportGenerator.generateReport(map, user, reportType, out);
        
        System.out.println("Inside the method");
        Font[] fonts = {
            new Font(Font.FontFamily.HELVETICA,36,Font.BOLD),
            new Font(Font.FontFamily.HELVETICA,12),
            new Font(Font.FontFamily.HELVETICA,12,Font.ITALIC)
        };
        System.out.println(map);
        System.out.println(user);
        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try
        {
//            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("Sample Report.pdf")); //ByteArrayOutputStream
//            ByteArrayOutputStream temp = new ByteArrayOutputStream(); //this is where the pdf will first be stored as a byte array, output stream since this is a binary file
            PdfWriter writer = PdfWriter.getInstance(document,baos); //temp);
            Rectangle rect = new Rectangle(PageSize.A4);
            document.setPageSize(rect);
            document.open();
            
            Paragraph title;
            //String role = records.getString("USERROLE")
            //if (role.equals("Admin") || role.equals("ADMIN") || role.equals("admin"))
            title = new Paragraph("\n\n\n\n\nGuest Report\n\n\n\n",fonts[0]);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.newPage();
            
            //table section
            PdfPTable table = new PdfPTable(2);
            PdfPCell columnOne = new PdfPCell();
            Paragraph contentOne = new Paragraph("Username",fonts[1]);
            contentOne.setAlignment(Element.ALIGN_CENTER);
            columnOne.addElement(contentOne);
            table.addCell(columnOne);
            PdfPCell columnTwo = new PdfPCell();
            Paragraph contentTwo = new Paragraph("User Role",fonts[1]);
            contentTwo.setAlignment(Element.ALIGN_CENTER);
            columnTwo.addElement(contentTwo);
            table.addCell(columnTwo);
            //for (int i = 0; i < username.length; i++)
            for (Map.Entry<String,String> entry : map.entrySet())
            {
                contentOne = new Paragraph(entry.getKey(),fonts[1]);
                contentOne.setAlignment(Element.ALIGN_CENTER);
                columnOne = new PdfPCell();
                columnOne.addElement(contentOne); //note that columnOne may have two elements onwards
                table.addCell(columnOne);
                contentTwo = new Paragraph(entry.getValue(),fonts[1]);
                contentTwo.setAlignment(Element.ALIGN_CENTER);
                columnTwo = new PdfPCell();
                columnTwo.addElement(contentTwo);
                table.addCell(columnTwo);
            }
            document.add(table);
            
            document.close();
            
            System.out.println("document completed");
            
            ByteArrayInputStream pdfToStamp = new ByteArrayInputStream(baos.toByteArray());
            
            
//            PdfReader reader = new PdfReader("Sample Report.pdf");
            PdfReader reader = new PdfReader(pdfToStamp);
            System.out.println("report is read");
            int n = reader.getNumberOfPages();
            PdfStamper stamper;
//            if (reportType.equals("Admin") || reportType.equals("ADMIN") || reportType.equals("admin"))
//                stamper = new PdfStamper(reader, new FileOutputStream("Admin Report.pdf"));
//                stamper = new PdfStamper(reader, baos);
//            else
//                stamper = new PdfStamper(reader, new FileOutputStream("Guest Report.pdf"));
            stamper = new PdfStamper(reader, baos);
            PdfContentByte pagecontent;
            for (int i = 0; i < n; ) {
                pagecontent = stamper.getOverContent(++i); //because i is incremented here, it's no longer necessary to add it on the for loop itself
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                LocalDateTime now = LocalDateTime.now();
                Phrase dateAndTimeGenerated = new Phrase("Date and Time Generated: " + dtf.format(now), fonts[2]);
                Phrase generatedBy = new Phrase("Generated By: " + user,fonts[2]);
                Phrase pageXOfY = new Phrase("Page " + i + " of " + n, fonts[2]);
                ColumnText.showTextAligned(pagecontent, Element.ALIGN_LEFT,
                        dateAndTimeGenerated,
                        document.left() + document.leftMargin(),
                        //document.left()*3 + document.leftMargin(),
                        document.bottom() - 12, 0);
                ColumnText.showTextAligned(pagecontent, Element.ALIGN_LEFT, 
                        generatedBy, 
                        document.left() + document.leftMargin(), 
                        document.bottom() - 24, 0);
                ColumnText.showTextAligned(pagecontent, Element.ALIGN_RIGHT,
                        pageXOfY,
                        document.right() - document.rightMargin(),
                        document.bottom() - 15, 0);
            }
            stamper.close();
            reader.close();
            System.out.println("report completed");
            
        } catch(Exception e)
        {
            e.printStackTrace();
        }
        
        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        byte[] byteArray = new byte[1024];
        int lengthOfBytes;
        while((lengthOfBytes = bais.read(byteArray)) != -1) {
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
