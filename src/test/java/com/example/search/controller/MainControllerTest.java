package com.example.search.controller;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.*;


@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MainControllerTest {
	private MockMvc mockMvc;
	 
    @Autowired
    private WebApplicationContext webApplicationContext;
 
    @Before
    public void setup() throws Exception {
        mockMvc = webAppContextSetup(webApplicationContext).build();
    }
 
    @Test
    public void test001() throws Exception {
        mockMvc.perform(get("/"))
               .andDo(print())
               .andExpect(status().isOk());
    }
}
