package com.yggdrasil.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by Yggdrasil on 16/12/6.
 */
@RestController
@RequestMapping("/select")
public class GetInfo {
    DeskRepository deskRepository;

    @Autowired
    public GetInfo(DeskRepository deskRepository) {
        this.deskRepository = deskRepository;
    }

    @RequestMapping("/desk")
    public List<Desk> getDesk (){
        return deskRepository.findAll();
    }
}
