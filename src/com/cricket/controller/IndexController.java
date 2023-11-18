package com.cricket.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map.Entry;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cricket.model.BatSpeed;
import com.cricket.model.Configuration;
import com.cricket.model.Speed;
import com.cricket.util.CricketFunctions;
import com.cricket.util.CricketUtil;

import net.sf.json.JSONObject;

@SessionAttributes(value = {"session_speed","session_bat_speed", "session_configuration"})
@Controller
public class IndexController 
{
	@RequestMapping(value = {"/"}, method={RequestMethod.GET,RequestMethod.POST}) 
	public String initialisePage(ModelMap model,
		@ModelAttribute("session_speed") Speed session_speed,
		@ModelAttribute("session_bat_speed") BatSpeed session_bat_speed,
		@ModelAttribute("session_configuration") Configuration session_configuration) throws JAXBException
	{
		if(new File(CricketUtil.CRICKET_DIRECTORY + CricketUtil.CONFIGURATIONS_DIRECTORY + CricketUtil.SPEED_XML).exists()) {
			session_configuration = (Configuration)JAXBContext.newInstance(Configuration.class).createUnmarshaller().unmarshal(
				new File(CricketUtil.CRICKET_DIRECTORY + CricketUtil.CONFIGURATIONS_DIRECTORY + CricketUtil.SPEED_XML));
		} else {
			session_configuration = new Configuration();
			JAXBContext.newInstance(Configuration.class).createMarshaller().marshal(session_configuration, 
				new File(CricketUtil.CRICKET_DIRECTORY + CricketUtil.CONFIGURATIONS_DIRECTORY + CricketUtil.SPEED_XML));
		}
		model.addAttribute("session_speed",session_speed);
		model.addAttribute("session_bat_speed",session_bat_speed);
		model.addAttribute("session_configuration",session_configuration);
		session_speed = new Speed(0);
		session_bat_speed = new BatSpeed(0);
		return "initialise";
	}

	@RequestMapping(value = {"/output"}, method={RequestMethod.GET,RequestMethod.POST}) 
	public String outputPage(ModelMap model,
		@ModelAttribute("session_speed") Speed session_speed,
		@ModelAttribute("session_bat_speed") BatSpeed session_bat_speed,
		@ModelAttribute("session_configuration") Configuration session_configuration)
	{
		model.addAttribute("session_speed",session_speed);
		model.addAttribute("session_bat_speed",session_bat_speed);
		model.addAttribute("session_configuration",session_configuration);
		return "speed";
	}
	
	@RequestMapping(value = {"/upload_initialise_data"}, method={RequestMethod.GET,RequestMethod.POST})    
		public @ResponseBody String uploadFormDataToSessionObjects(MultipartHttpServletRequest request,
		@ModelAttribute("session_speed") Speed session_speed,
		@ModelAttribute("session_bat_speed") BatSpeed session_bat_speed,
		@ModelAttribute("session_configuration") Configuration session_configuration) throws JAXBException 
	{
		
		for (Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
			if(entry.getKey().equalsIgnoreCase("select_broadcaster")) {
				session_configuration.setBroadcaster(entry.getValue()[0]);
			}else if(entry.getKey().equalsIgnoreCase("speed_directory_path")) {
				session_configuration.setPrimaryIpAddress(entry.getValue()[0]);
	        	if(!session_configuration.getPrimaryIpAddress().substring(
	        			session_configuration.getPrimaryIpAddress().length() - 1).equalsIgnoreCase("\\")) {
	        		session_configuration.setPrimaryIpAddress(session_configuration.getPrimaryIpAddress() + "\\");
	        	}
			}else if(entry.getKey().equalsIgnoreCase("speed_destination_file_path")) {
				session_configuration.setFilename(entry.getValue()[0]);
			}else if(entry.getKey().equalsIgnoreCase("bat_speed_source_file_path")) {
				session_configuration.setSecondaryIpAddress(entry.getValue()[0]);
			}else if(entry.getKey().equalsIgnoreCase("bat_speed_destination_file_path")) {
				session_configuration.setSecondaryFilename(entry.getValue()[0]);
			}
		}

		JAXBContext.newInstance(Configuration.class).createMarshaller().marshal(session_configuration, 
				new File(CricketUtil.CRICKET_DIRECTORY + CricketUtil.CONFIGURATIONS_DIRECTORY + CricketUtil.SPEED_XML));

		return JSONObject.fromObject(session_configuration).toString();

	}
	
	@RequestMapping(value = {"/processCricketProcedures"}, method={RequestMethod.GET,RequestMethod.POST})    
	public @ResponseBody String processCricketProcedures(
			@RequestParam(value = "whatToProcess", required = false, defaultValue = "") String whatToProcess,
			@RequestParam(value = "valueToProcess", required = false, defaultValue = "") String valueToProcess,
			@ModelAttribute("session_speed") Speed session_speed,
			@ModelAttribute("session_bat_speed") BatSpeed session_bat_speed,
			@ModelAttribute("session_configuration") Configuration session_configuration) throws JAXBException, IOException
	{	
		switch (whatToProcess.toUpperCase()) {
		case "SPEED":
			
			if(session_speed == null) {
				session_speed = new Speed(0);
			}

			session_speed = CricketFunctions.saveCurrentSpeed(session_configuration.getBroadcaster().toUpperCase(), 
					session_configuration.getPrimaryIpAddress(), session_configuration.getFilename(), session_speed);

			return JSONObject.fromObject(session_speed).toString();

		case "BAT_SPEED":
			
			if(session_bat_speed == null) {
				session_bat_speed = new BatSpeed(0);
			}

			if(session_configuration.getSecondaryIpAddress() != null && !session_configuration.getSecondaryIpAddress().isEmpty()) {
				session_bat_speed = CricketFunctions.processCurrentBatSpeed(session_configuration.getSecondaryIpAddress(), 
					session_configuration.getSecondaryFilename(),session_bat_speed);
				System.out.println("session_bat_speed = " + session_bat_speed);
				return JSONObject.fromObject(session_bat_speed).toString();
			} else {
				return JSONObject.fromObject(null).toString();
			}
			
		default:
			
			return JSONObject.fromObject(null).toString();
		
		}
	}

	@ModelAttribute("session_speed")
	public Speed session_speed(){
		return new Speed();
	}
	@ModelAttribute("session_bat_speed")
	public BatSpeed session_bat_speed(){
		return new BatSpeed();
	}
	@ModelAttribute("session_configuration")
	public Configuration session_configuration(){
		return new Configuration();
	}
	
}