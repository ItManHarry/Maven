# 配置Maven私服

- 下载Maven web程序（war）
	
	nexus.war
	
- 部署war文件，使用Tomcat即可
	
	文件发布至webapps目录下即可
	
- 配置私服的仓库地址

	配置文件路径：
		
		webapps\nexus\WEB_INF\classes\nexus.properties
		
	配置属性：
		
		nexus-work=本地的Maven仓库地址即可
	
- 启动Tomcat

- 浏览器访问 nexus

	http://localhost:8080/nexus

- 配置本地Maven setting.xml文件

```xml
	<mirrors>		
		<mirror>
		  <id>nexus</id>
		  <mirrorOf>*</mirrorOf>		  
		  <url>http://localhost:8080/nexus/content/groups/public/</url>
		</mirror>
	</mirrors>
	<profiles>    
		<profile>
		  <id>nexus</id>
		  <repositories>
			<repository>
				<id>central</id>			  
				<url>http://localhost:8080/nexus/content/repositories/central</url>
				<releases>
					<enbaled>true</enabled>
				</releases>
				<snapshots>
					<enbaled>true</enabled>
				</snapshots>
			</repository>
		  </repositories>
		  <pluginRepositories>
			<pluginRepository>
				<id>central</id>			  
				<url>http://localhost:8080/nexus/content/repositories/central</url>
				<releases>
					<enbaled>true</enabled>
				</releases>
				<snapshots>
					<enbaled>true</enabled>
				</snapshots>
			</pluginRepository>
		  </pluginRepositories>
		</profile>    
	</profiles>
```
