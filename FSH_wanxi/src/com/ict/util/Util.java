package com.ict.util;
/**
 * 工具类。提供各种工具
 * @author Kong
 * @Version 1.0
 */
//import java.util.HashMap;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Util {
	public String compare (HashMap<String,String> hm, String macAddr){
		Iterator<Entry<String,String>> iter = 
				hm.entrySet().iterator(); 
		while (iter.hasNext()) { 
			Map.Entry<String,String> entry = 
					(Entry<String, String>) iter.next(); 
			String key = (String)entry.getKey(); 
			//String val = (String)entry.getValue(); 
			String regEx="LED";
			Pattern p=Pattern.compile(regEx);
			Matcher m=p.matcher(key);
			m.find();
			
		
		}
		return null;

	}
	/**
	 * 根据value返回hashmap的所有key
	 * @title getKey
	 * @author kong
	 * @version 1.1
	 * @return String
	 */
	public static String getKey (HashMap<String,String> hm, String value){
	    String result="";
		Iterator<Entry<String,String>> iter = 
				hm.entrySet().iterator(); 
		while (iter.hasNext()) { 
			Map.Entry<String,String> entry = 
					(Entry<String, String>) iter.next(); 
			String key = (String)entry.getKey(); 
			String val = (String)entry.getValue(); 
			if(val.equals(value)){
			    if(result=="")
			        result+=key;
			    else {
                    result+=" "+key;
                }
			}
		}
		if(result!="")
		    return result;
		else
		    return null;
	}
	/**
	 * 将所有key组合成String返回
	 * @title getAllKey
	 * @author kong
	 * @version 1.0
	 * @return String
	 */
	public static String getAllKey(HashMap<String,String> hm){
		String key="";
		Iterator<Entry<String,String>> iter = 
				hm.entrySet().iterator(); 
		while (iter.hasNext()) { 
			Map.Entry<String,String> entry = 
					(Entry<String, String>) iter.next(); 
			key += (String)entry.getKey()+" ";
		}
		
		return key;
	}
	/**
	 * 判断a是否包含b
	 * @title include
	 * @author kong
	 * @version 1.0
	 * @return boolean
	 */
	public static boolean include (String a, String b){
		Pattern p=Pattern.compile(b);
		Matcher m=p.matcher(a);
		return m.find();
	}
	/**
	 * 判断a是否包含b,若包含则返回a
	 * @title includeWhat
	 * @author kong
	 * @version 1.0
	 * @return String
	 */
	public static String includeWhat (String a, String b){
		if(include(a,b)){
			return a;
		}else{
			return null;
		}
	}
	
	/**
	 * 判断hashmap中是否含有某个key a 若含有则返回key
	 * @title findKey
	 * @author kong
	 * @version 1.0
	 * @return String
	 */
	public static String findKey (HashMap<String,String> hm ,String a){
		
		String allkey=getAllKey(hm);
		String[] onelineSet = allkey.split(" ");
		for(int i=0; i<onelineSet.length; i++){
			String key = includeWhat(onelineSet[i],a);
			if(key!=null){
				return key;
			}
		}
		return null;
	}
}
