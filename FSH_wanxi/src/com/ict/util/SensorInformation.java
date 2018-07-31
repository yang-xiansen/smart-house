package com.ict.util;

import java.util.HashMap;
import java.util.Map;

public class SensorInformation {

	private static Map<String,String> sensorInformation = new HashMap<String,String>();

	public static Map<String,String> getSensorInformation()
	{
		return sensorInformation;
	}



}
