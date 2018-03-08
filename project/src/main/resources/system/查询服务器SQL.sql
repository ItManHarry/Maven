select 
        a.tid as tid,
        a.machineName as machineName,
        a.machineModel as machineModel,
        a.machineUsage as machineUsage,
        a.serialNumber as serialNumber,
        b.cdvw as rent,
        a.rentEndDt as rentEndDt,
        g.cdvw as os,
        a.ip as ip,
        a.cpuModel as cpuModel,
        a.cpuCore as cpuCore,
        a.memory as memory,
        a.disk as disk,
        c.cdvw as usageCategory,
        d.cdvw as middleware,
        a.envirDistinguish as envirDistinguish,
        e.cdvw as machineAdd,
        a.run as run,
        f.teamnm as manageBy
			from server_info a 
      left join sys_code b
			on a.rent = b.cdvl
      and b.code = 'RENT'
      left join sys_code c
			on a.usageCategory = c.cdvl
      and c.code = 'MCHUSAGE'
      left join sys_code d
			on a.middleware = d.cdvl
      and d.code = 'MIDDLEWARE'
      left join sys_code e
			on a.machineAdd = e.cdvl
      and e.code = 'SERADD'
      left join sys_team f
      on a.manageBy = f.tid
      left join sys_code g
			on a.os = g.cdvl
      and g.code = 'OSTP'
      order by a.tid;
      
      select * from sys_team;