## Welcome to sampleTicket

The simply flexible ticket system with additional features and possibilities. 
Prepared for forking and copying as is.

[![Build Status](https://travis-ci.org/Aqueelone/sampleTicket.svg?branch=develop)](https://travis-ci.org/Aqueelone/sampleTicket)
[![Dependency Status](https://gemnasium.com/Aqueelone/sampleTicket.svg)](https://gemnasium.com/Aqueelone/sampleTicket)

## Installation and Setup

sampleTicket is a traditional Ruby on Rails application, meaning that you can
configure and run it the way you would a normal Rails application.

See the [INSTALL](INSTALL.md) file for more details.

## Issue resolution process:
1. Customer signed up in system.
It is necessary because we have to know customer's email
2. Customer makes up a ticket for his issue. For this he can choose: 
    - category for the ticket. (All categories had to be added by admins or moderators) 
    - desired ticket status (this status cannot be "is_moderable" or "closed") 
    - the title of the ticket and the description of his issue
3. After this the customer will receive a message about this ticket via email. 
4. Then the customer could see this ticket in topics: "My tickets" (tickets as they are), "My categories" (tickets by categories), "My Status" (tickets by statuses) 
5. Also the customer could see "My profile" where he could:
    - change own password or email
    - see all his tickets
    - make up own widgets from the set of widget templates to organize own waiting asigments of tickets
    - see SLA, set and designed for him by admins or moderators
    - see his tickets escalation's level
    - see persons who had been assigned for his issues
    - see histories of own tickets 
    - reopen own tickets when it was "closed"
6. Moderators, who had been assigned for this category, could see this issue, using specially  designed widgets.
7. After fetching this issue, moderators could: 
    - change different ticket status for choosing other SLA and escalation cost,  
    - assign persons for resolving this issue and make ticket status from suitable "is_moderable" statuses sets 
    - comment this for starting discussions with the customer 
    - make another ticket, linked to it, if it is necessary
8. While the moderator is doing his actions, escalation system provides time control for solving this issue.
9. When it is required, the escalation system gets up the escalation level on this issue with sending email message for the next level of the  persons responsible for this
10. When the issue is solved, the moderator changes the ticket status to  "is_closed" type status from the suitable sets of statuses.
11. If the customer doesn't agree with the status of his ticket as "resolved", he can set "reopened" status of it.

See more:
* [Issue tracking system (definition of this)](http://en.wikipedia.org/wiki/Issue_tracking_system)
* [Support Ticket Best Practices](https://www.h2desk.com/blog/customers-easy-support/)

##TO-DO
1. Widgets System such as "Waiting for clients", "Waiting for aproving" etc. with widget templates and windgets rules sets
2. Responsible persons assigments system
3. "Ticket Escalation System"
4. Comment system
3. Minichat with SSE integrations
4. Fixing of tests
5. Deploying to Amazon AWS