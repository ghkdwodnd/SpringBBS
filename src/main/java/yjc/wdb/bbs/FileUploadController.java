package yjc.wdb.bbs;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import yjc.wdb.bbs.util.MediaUtils;
import yjc.wdb.bbs.util.UploadFileUtils;

@Controller
public class FileUploadController {
	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);
	
//	@Inject
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value="uploadForm",method = RequestMethod.GET)
	public void uploadForm(){
		logger.debug("uploadForm Requested");
		logger.info("uploadForm Requested");
		logger.warn("uploadForm Requested");
		logger.error("uploadForm Requested");
	}
	@RequestMapping(value="upload",method = RequestMethod.POST)
	public String upload(MultipartFile file,Model model) throws Exception{
		logger.debug("uploadForm Requested");
		logger.info("originalName:"+file.getOriginalFilename());
		logger.info("size:"+file.getSize());
		logger.info("contentType : "+file.getContentType());
		logger.info("server FileName : "+file.getName());

		String savedName = UploadFileUtils.uploadFile(file.getOriginalFilename() ,uploadPath,file.getBytes());
		model.addAttribute("savedName", savedName);
		return "uploadResult";
	}	
	
	@RequestMapping(value="uploadAjax", method = RequestMethod.GET)
	public void uploadAjax(){
		
	}
	
	@RequestMapping(value="uploadAjax",method = RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		logger.info("originalName : "+file.getOriginalFilename());
		logger.info("size:"+file.getSize());
		logger.info("contentType : "+file.getContentType());
		
		String savedName = UploadFileUtils.uploadFile(file.getOriginalFilename() ,uploadPath,file.getBytes());
		return new ResponseEntity<>(savedName,HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping("displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;
		
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mediaType = MediaUtils.getMediaType(ext);
		
		InputStream in = null;
		
		logger.info("File Name: " + fileName);
		
		HttpHeaders headers = new HttpHeaders();
		//uploadPath : resources/upload
		//fileName : /2017/05/18/ThumbNail_rose_XXXXX.jpg
		try{
			in = new FileInputStream(uploadPath+fileName);
			if(mediaType != null){
				headers.setContentType(mediaType);
			}else{
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				String fN = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
				headers.add("Content-Disposition", "attachment; filename=\""+fN+"\"");
			}
			byte[] data = IOUtils.toByteArray(in);
			entity = new ResponseEntity<byte[]>(data, headers, HttpStatus.CREATED);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}finally{
			in.close();
		}
		
		return entity;
	}
	 @ResponseBody
     @RequestMapping(value="deleteFile",  method=RequestMethod.DELETE, produces = "text/plain;charset=UTF-8")
     public ResponseEntity<String> deleteFile(@RequestBody MyFile myfile){
        String fileName= myfile.getFileName();
        try{
           fileName = URLDecoder.decode(fileName,"UTF-8");
        }catch (UnsupportedEncodingException e) {
        // TODO: handle exception
           e.printStackTrace();
        }
  
        logger.info("delete file: " +fileName);
        String ext = fileName.substring(fileName.lastIndexOf(".")+1);
        
     
        MediaType mType = MediaUtils.getMediaType(ext);
        if(mType != null){ //Image file
           //원본 이미지를 삭제하기
           String folderPath = fileName.substring(0, 12);
           String orgName = fileName.substring(12+"thumbNail_".length());
           File orgImgFile = new File(uploadPath+(folderPath+orgName).replace('/',File.separatorChar));
           orgImgFile.delete();
        }
        //ThumNail이미지 삭제
        File orgFile = new File(uploadPath+fileName);
        orgFile.delete();
        
        ResponseEntity<String> entity = 
              new ResponseEntity<String>("deleted",HttpStatus.OK);
        
        return entity;
        
     }
	
//	@ResponseBody
//	@RequestMapping(value="deleteFile",method=RequestMethod.DELETE, produces = "text/plain;charset=UTF-8")
//	public ResponseEntity<String> deleteFile(@RequestBody MyFile myfile){
//		String fileName = myfile.getFileName();
//		try {
//			fileName = URLDecoder.decode(fileName, "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		logger.info("delete file:" + fileName);
//		String ext = fileName.substring(fileName.lastIndexOf("."));
//		
//		MediaType mType = MediaUtils.getMediaType(ext);
//		if(mType != null){ //image file
//			//원본 이미지를 삭제하기
//			String folderPath = fileName.substring(0, 12);
//			logger.info("folderPath:"+folderPath);
//			String orgName = fileName.substring(12+"thumbNail_".length());
//			File orgImgFile = new File(uploadPath+(folderPath+orgName).replace('/', File.separatorChar));
//			logger.info("original Image:"+orgImgFile.getAbsolutePath());
//			orgImgFile.delete();
//		}
//		File orgFile = new File((uploadPath+fileName).replace('/', File.separatorChar));
//		orgFile.delete();
//		
//		ResponseEntity<String> entity = new ResponseEntity<String>("deleted",HttpStatus.OK);
//		return entity;
//	}
}

class MyFile{
	private String fileName;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}