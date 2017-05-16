package yjc.wdb.bbs;

import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

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
		logger.info("contentType"+file.getContentType());
		
		return new ResponseEntity<>(file.getOriginalFilename(),HttpStatus.CREATED);
	}
}
