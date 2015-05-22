## Welcome to sampleTicket

The simply flexible ticket system with additional features and possibilities. 
Prepared for forking and copying as is.

[![Build Status](https://travis-ci.org/Aqueelone/sampleTicket.svg?branch=develop)](https://travis-ci.org/Aqueelone/sampleTicket)
[![Dependency Status](https://gemnasium.com/Aqueelone/sampleTicket.svg)](https://gemnasium.com/Aqueelone/sampleTicket)

## Installation and Setup

sampleTicket is a traditional Ruby on Rails application, meaning that you can
configure and run it the way you would a normal Rails application.

See the  file for more details.

## Issue resolution process:
1. Customer signed up in system.
It is necessary because we have to know customer's email
2. Customer make up ticket for his issue. For this he can choose: 
    a) category for this. (All categories had to added by admins or moderators) 
    b) desired ticket status (this status cannot be "is_moderable" or "closed") 
    c) title of ticket and description of his issue
3. After this customer will receive via email letter about this ticket
4. After this customer could see this ticket in "My tickets" (tickets as is), "My categories" (tickets by categories), "My Status" (tickets by statuses) topics
5. Also customer could see "My profile" where:
    a) he could change own password or emeil
    b) he could see all own tickets
    c) he could make up own widgets from set of widget templates to organize own waiting asigments of tickets
    d) he could see SLA for self, wich had been assigned by admins or moderators
    e) he could see his tickets escalation's level
    f) he could see wich persons had been assigned for his issues
    g) he could see histories of own tickets 
    h) he could reopen own tickets when it was "closed"
6. Moderator, wich had been assigned for this category, could see this issue, using for this special  designed widgets.
7. After fetching this issue, moderator could: 
    a) change different ticket status for choosing other SLA and escalation cost,  
    b) assign persons for resolving this issue and make ticket status from suitable "is_moderable" statuses sets 
    c) commented this for starting discussions with customer 
    d) could make another ticket, linked for this, if it is necessary
8. While moderator is doing his actions, escalation system provide time control for solve this issue.
9. When it is required, escalation system get up escalation level for this issue with sending email message for responsible persons
10. When issue was solved, moderator change ticket status to  "is_closed" type status from suitable sets of statuses.
11. If customer don't agree with status of his ticket as "solved", he could set "reopened" status of it. 

See more:
[Issue tracking system (definition of this)](http://en.wikipedia.org/wiki/Issue_tracking_system)
[Support Ticket Best Practices](https://www.h2desk.com/blog/customers-easy-support/)

##TO-DO

1. Comment system
2. Widgets such as "Waiting for clients", "Waiting for aproving" etc.
3. Minichat with SSE integrations
4. Fixing of tests
5. Deploying to Amazon AWS