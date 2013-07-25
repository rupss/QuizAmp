package Users;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class upload
 */
@WebServlet("/upload")
public class upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		/* from http://www.coderanch.com/t/537264/open-source/Image-Upload-directory-HTML-form*/
		/* also: http://commons.apache.org/proper/commons-fileupload//using.html*/
        FileItemFactory factory = new DiskFileItemFactory();  
        ServletFileUpload upload = new ServletFileUpload(factory);  

        try {  
//            System.out.println("request: "+request);  
//            System.out.println("request end");  
            List items = upload.parseRequest(request);  
            Iterator iterator = items.iterator();  
            while (iterator.hasNext()) {  
                FileItem item = (FileItem) iterator.next();  

                if (!item.isFormField()) {  
                    String fileName = item.getName(); 

                    String root = getServletContext().getRealPath("/");  
//                    System.out.println(root);
                    File path = new File(root + "WebContent/images"); 
//                    System.out.println(path);
                    if (!path.exists()) {  
                        boolean status = path.mkdirs();  
                    }  

                    File uploadedFile = new File(path + "/" + fileName);  
//                    System.out.println(uploadedFile.getAbsolutePath());  
                    item.write(uploadedFile);  
                }  
            }  
        } catch (FileUploadException e) {  
            e.printStackTrace();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
	}

}
