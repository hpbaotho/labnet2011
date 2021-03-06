﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace DomainModel
{
    public class VMDoctor
    {
        public string Name { get; set; }

        public string UserName { get; set; }

        public string Password { get; set; }

        public string PasswordVerify { get; set; }

        public string ConnectionCode { get; set; }

        public string Address { get; set; }

        public string Phone { get; set; }

        public string Email { get; set; }

        public string BirthDate { get; set; }
    }
}
