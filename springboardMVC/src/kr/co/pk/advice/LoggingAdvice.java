package kr.co.pk.advice;

import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Calendar;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

//객체를 자동으로 생성하기 위한 어노테이션
@Component
//Advice 클래스로 만들기 위한 어노테이션
@Aspect
public class LoggingAdvice {

	//advice로 수행될 메소드
	//pointcut 작성
	//접근지정자는 public 다음 *은 모든 리턴 타입
	//kr.co.pk.. 은 kr.co.pk 패키지 안에 있는 모든
	//*Dao 는 Dao로 끝나는 클래스 .* 은 메소드 이름이 무엇이든지
	//(..)은 매개변수 개수에 상관없이
	@Around("execution(public * kr.co.pk..*Dao.*(..))")
	public Object invoke(ProceedingJoinPoint joinPoint)
			throws Throwable{
		//pointcut으로 설정된 메소드가 호출되기 전에 수행할 내용
		
		//메소드 이름 가져오기
		String methodName = joinPoint.getSignature().toLongString();
		//현재 시간 만들기
		Calendar cal = Calendar.getInstance();
		java.util.Date date = new java.util.Date(
			cal.getTimeInMillis());
		
		//파일에 문자열 기록하기 - 파일이 존재하면 이어쓰기
		FileOutputStream fos = 
			new FileOutputStream("d:\\log.txt", true);
		//문자열을 기록할 수 있는 클래스의 객체 만들기
		PrintWriter pw = new PrintWriter(fos);
		//파일에 기록
		pw.println(methodName + " " + date.toString() + "\n");
		pw.flush();
		
		pw.close();
		
		Object obj = joinPoint.proceed();
		
		//pointcut으로 설정된 메소드가 호출 된 후에 수행할 내용
		
		return obj;
	}
}




